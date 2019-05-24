//
//  SourceryWorker.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Errors
import Foundation
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

/**
 To generate mocks correctly we have to do a text replacement and run sourcery twice.
    This worker will perform the following tasks
    1. Find all files in sourceFolder
    1.1 (Optional) Replace also in individual files
    2. Run sourcery to generate the protocols
    3. Revert Replace occurances
    4. Run sourcery to generate the mocks
    6. Add imports to output
 */
public class SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]

    // sourcery:begin:skipProtocol
    public static let queue: DispatchQueue = DispatchQueue(label: "be.dooz.highway.sourceryWorker")
    public static let mockableInline = "// highway:inline:"
    public static let mockableEnd = "// highway:end"
    public static let protocolGeneratableInline = "// sourcery:inline:"
    public static let protocolGeneratalbeEnd = "// sourcery:end"
    // sourcery:end

    public let name: String
    public let sourceryYMLFile: FileProtocol

    // MARK: - Private

    private var sourcery: SourceryProtocol
    private let queue: HighwayDispatchProtocol

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol

    // sourcery:includeInitInProtocol
    public required init(
        sourcery: SourceryProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = SourceryWorker.queue
    )
    {
        self.sourcery = sourcery
        self.terminal = terminal
        self.signPost = signPost
        self.queue = queue
        sourceryYMLFile = self.sourcery.sourceryYMLFile
        name = self.sourcery.name
    }

    fileprivate func createSourceryProcess(in folder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol
    {
        let sourceryProcess = Process()
        try sourceryProcess.executable(set: executableFile)
        sourceryProcess.currentDirectoryPath = folder.path
        sourceryProcess.arguments = ["--config", sourcery.sourceryYMLFile.path]
        return sourceryProcess
    }

    public func attempt(in folder: FolderProtocol, _ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        var executableFile: FileProtocol!

        do
        {
            executableFile = try sourcery.executableFile()
        }
        catch
        {
            async { throw HighwayError.highwayError(atLocation: pretty_function(), error: error) }
            return
        }

        let context = (
            sourcery: sourcery,
            terminal: terminal,
            replace: replace,
            signPost: signPost,
            createSourceryProcess: createSourceryProcess
        )

        queue.async
        {
            do
            {
                let sourceryProcessGenerateProtocols = try context.createSourceryProcess(folder, executableFile)
                let sourceryProcessGenerateMocks = try context.createSourceryProcess(folder, executableFile)
                // 1. Store all files in a sequence

                var fileSequences = [AnySequence<File>]()

                for folder in context.sourcery.sourcesFolders
                {
                    context.signPost.verbose("🧙‍♂️\(folder.name)")

                    let fileSequence = folder.makeFileSequence(recursive: true, includeHidden: false)

                    fileSequences.append(AnySequence(fileSequence))
                }

                // 1.1 (Optional) Replace also in individual files

                if let individualFiles = context.sourcery.individualSourceFiles
                {
                    fileSequences.append(AnySequence(individualFiles))
                }

                // 2. Run sourcery to generate the protocols

                context.signPost.verbose("🧙‍♂️ Generating PROTOCOLS")

                context.signPost.verbose("🧙‍♂️ \(try context.terminal.runProcess(sourceryProcessGenerateProtocols).joined(separator: "\n"))")

                // 3. Replace to be able to mock

                context.signPost.verbose("🧙‍♂️ All files in Sources folders are reverted to status before generating protocols.")

                try fileSequences.forEach
                { fileSequence in
                    try context.replace(
                        fileSequence,
                        (current: SourceryWorker.protocolGeneratableInline, replace: SourceryWorker.mockableInline),
                        (current: SourceryWorker.protocolGeneratalbeEnd, replace: SourceryWorker.mockableEnd)
                    )
                }

                // 4. Run sourcery to generate the mocks

                context.signPost.verbose("🧙‍♂️ Generating MOCKS")

                let sourceryWorkerOutput = try context.terminal.runProcess(sourceryProcessGenerateMocks)

                // 5. Revert string replacements - Back to normal

                try fileSequences.forEach
                { fileSequence in
                    try context.replace(
                        fileSequence,
                        (current: SourceryWorker.mockableInline, replace: SourceryWorker.protocolGeneratableInline),
                        (current: SourceryWorker.mockableEnd, replace: SourceryWorker.protocolGeneratalbeEnd)
                    )
                }

                // 6. Add imports to output

                context.signPost.verbose("🧙‍♂️ Add imports to output")

                try context.sourcery.outputFolder.makeFileSequence(recursive: true, includeHidden: false).forEach
                { file in
                    guard let _import = (self.sourcery.imports.first { file.name.hasPrefix($0.template) }) else { return }

                    var allLines = try file.readAllLines()

                    var importStatements = _import.names
                        .sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                        .map { $0.testable ? "@testable import \($0.name)" : "import \($0.name)" }

                    importStatements.append("\n")

                    allLines = importStatements + allLines

                    guard let data = allLines.joined(separator: "\n").data(using: .utf8) else { return }

                    try file.write(data: data)
                }

                async { sourceryWorkerOutput }
            }
            catch
            {
                async { throw error }
            }
        }
    }

    // MARK: - Private

    private func replace(in fileSequence: AnySequence<File>, inline: (current: String, replace: String), end: (current: String, replace: String)) throws
    {
        try fileSequence.forEach
        { file in
            guard file.extension == "swift", file.name != "SourceryWorker.swift", file.name != "SourceryWorkerSpec.swift" else
            {
                return
            }

            let content = try file.readAsString()
                .replacingOccurrences(of: inline.current, with: inline.replace)
                .replacingOccurrences(of: end.current, with: end.replace)
            try file.write(string: content, encoding: .utf8)
        }
    }
}
