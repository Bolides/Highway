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

/// To generate mocks correctly we have to do a text replacement and run sourcery twice.
/// This worker will perform the following tasks
/// 1. Find all files in sourceFolder
/// 1.1 (Optional) Replace also in individual files
/// 2. Run sourcery to generate the protocols
/// 3. Revert Replace occurances
/// 4. Run sourcery to generate the mocks
/// 6. Add imports to output
public struct SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]

    // sourcery:begin:skipProtocol
    public static let queue: DispatchQueue = DispatchQueue(label: "be.dooz.highway.sourceryWorker")
    public static let mockableInline = "// highway:inline:"
    public static let mockableEnd = "// highway:end"
    public static let protocolGeneratableInline = "// sourcery:inline:"
    public static let protocolGeneratalbeEnd = "// sourcery:end"
    // sourcery:end

    public let sourcery: SourceryProtocol

    // MARK: - Private

    private let queue: HighwayDispatchProtocol

    private let signPost: SignPostProtocol
    private let terminalWorker: TerminalWorkerProtocol

    // sourcery:includeInitInProtocol
    public init(
        sourcery: SourceryProtocol,
        terminalWorker: TerminalWorkerProtocol = TerminalWorker(),
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = SourceryWorker.queue
    ) throws
    {
        self.sourcery = sourcery
        self.terminalWorker = terminalWorker
        self.signPost = signPost
        self.queue = queue
    }

    public func executor() throws -> ArgumentExecutableProtocol
    {
        return SourceryExecutor(sourcery)
    }

    public func attempt(_ asyncSourceryWorkerOutput: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        queue.async
        {
            do
            {
                self.signPost.verbose("Executing sourcery from executable \(try self.executor().executableFile())")

                self.signPost.verbose("🧙‍♂️ All files in Sources folders will be scanned for occurrences of `/// sourcery:` and replaced with `/// sourcery:` to be able generate protocols.")

                // 1. Store all files in a sequence

                var fileSequences = [AnySequence<File>]()

                for folder in self.sourcery.sourcesFolders
                {
                    self.signPost.verbose("🧙‍♂️\(folder.name)")

                    let fileSequence = folder.makeFileSequence(recursive: true, includeHidden: false)

                    fileSequences.append(AnySequence(fileSequence))
                }

                // 1.1 (Optional) Replace also in individual files

                if let individualFiles = self.sourcery.individualSourceFiles
                {
                    fileSequences.append(AnySequence(individualFiles))
                }

                // 2. Run sourcery to generate the protocols

                self.signPost.verbose("🧙‍♂️ Generating PROTOCOLS")

                self.signPost.verbose("🧙‍♂️ \(try self.terminalWorker.terminal(task: .sourcery(try self.executor())).joined(separator: "\n"))")

                // 3. Replace to be able to mock

                self.signPost.verbose("🧙‍♂️ All files in Sources folders are reverted to status before generating protocols.")

                try fileSequences.forEach
                { fileSequence in
                    try self.replace(
                        in: fileSequence,
                        inline: (current: SourceryWorker.protocolGeneratableInline, replace: SourceryWorker.mockableInline),
                        end: (current: SourceryWorker.protocolGeneratalbeEnd, replace: SourceryWorker.mockableEnd)
                    )
                }

                // 4. Run sourcery to generate the mocks

                self.signPost.verbose("🧙‍♂️ Generating MOCKS")

                let sourceryWorkerOutput = try self.terminalWorker.terminal(task: .sourcery(try self.executor()))

                // 5. Revert string replacements - Back to normal

                try fileSequences.forEach
                { fileSequence in
                    try self.replace(
                        in: fileSequence,
                        inline: (current: SourceryWorker.mockableInline, replace: SourceryWorker.protocolGeneratableInline),
                        end: (current: SourceryWorker.mockableEnd, replace: SourceryWorker.protocolGeneratalbeEnd)
                    )
                }

                // 6. Add imports to output

                self.signPost.verbose("🧙‍♂️ Add imports to output")

                try self.sourcery.outputFolder.makeFileSequence(recursive: true, includeHidden: false).forEach
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

                asyncSourceryWorkerOutput { sourceryWorkerOutput }
            }
            catch
            {
                asyncSourceryWorkerOutput { throw error }
            }
        }
    }

    // MARK: - Private

    private func replace(in fileSequence: AnySequence<File>, inline: (current: String, replace: String), end: (current: String, replace: String)) throws
    {
        try fileSequence.forEach
        { file in
            guard file.extension == "swift", file.name != "SourceryWorker.swift" else
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
