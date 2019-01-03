//
//  SourceryWorker.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Foundation
import os
import SignPost
import SourceryAutoProtocols
import SwiftFormatWorker
import Task
import Terminal
import ZFile

public protocol SourceryWorkerProtocol
{
    /// sourcery:inline:SourceryWorker.AutoGenerateProtocol
    func executor() throws -> ArgumentExecutableProtocol
    func attempt(_ async: (@escaping (@escaping SourceryWorker.SyncOutput) -> Void))
    /// sourcery:end
}

/// To generate mocks correctly we have to do a text replacement and run sourcery twice.
/// This worker will perform the following tasks
/// 1. Find all files in sourceFolder
/// 1.1 (Optional) Replace also in individual files
/// 2. Run sourcery to generate the protocols
/// 3. Revert Replace occurances
/// 4. Run sourcery to generate the mocks
/// 6. Add imports to output
public class SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]

    private let sourcery: SourceryProtocol
    private let signPost: SignPostProtocol
    private let terminalWorker: TerminalWorkerProtocol

    private let mockableInline = "/// sourcery:inline:"
    private let mockableEnd = "/// sourcery:end"
    private let protocolGeneratableInline = "// sourcery:inline:"
    private let protocolGeneratalbeEnd = "// sourcery:end"

    private let queue: DispatchQueue

    private let swiftFormatWorker: SwiftFormatWorkerProtocol?

    struct Error: Swift.Error
    {
        let message: String
    }

    /// Optionaly add swiftFormateWorker to run SwiftFormat when done generating code. If you add non swiftformat will not run on generated code.
    public init(
        sourcery: SourceryProtocol,
        swiftFormatWorker: SwiftFormatWorkerProtocol? = nil,
        terminalWorker: TerminalWorkerProtocol = TerminalWorker(),
        signPost: SignPostProtocol = SignPost.shared,
        queue: DispatchQueue = DispatchQueue(label: "be.dooz.highway.sourceryWorker")
    )
    {
        self.sourcery = sourcery
        self.terminalWorker = terminalWorker
        self.signPost = signPost
        self.queue = queue
        self.swiftFormatWorker = swiftFormatWorker
    }

    public func executor() throws -> ArgumentExecutableProtocol
    {
        return SourceryExecutor(sourcery)
    }

    public func attempt(_ async: (@escaping (@escaping SourceryWorker.SyncOutput) -> Void))
    {
        queue.async
        { [weak self] in
            guard let `self` = self else { return }

            do
            {
                self.signPost.verbose("🧙‍♂️ All files in Sources folders will be scanned for occurrences of `/// sourcery:` and replaced with `/// sourcery:` to be able generate protocols.")

                // 1. Find all files in sourceFolder and Replace occurances of inline with 3 slashes

                var fileSequences = [AnySequence<File>]()

                for folder in self.sourcery.sourcesFolders
                {
                    let fileSequence = folder.makeFileSequence(recursive: true, includeHidden: false)

                    try self.replace(
                        in: AnySequence(fileSequence),
                        inline: (current: self.mockableInline, replace: self.protocolGeneratableInline),
                        end: (current: self.mockableEnd, replace: self.protocolGeneratalbeEnd)
                    )

                    fileSequences.append(AnySequence(fileSequence))
                }

                // 1.1 (Optional) Replace also in individual files

                if let individualFiles = self.sourcery.individualSourceFiles
                {
                    let individualFileSequence = AnySequence(individualFiles)

                    try self.replace(
                        in: individualFileSequence,
                        inline: (current: self.mockableInline, replace: self.protocolGeneratableInline),
                        end: (current: self.mockableEnd, replace: self.protocolGeneratalbeEnd)
                    )

                    fileSequences.append(individualFileSequence)
                }

                // 2. Run sourcery to generate the protocols

                self.signPost.verbose("🧙‍♂️ Generating protocols")

                self.signPost.verbose("🧙‍♂️ \(try self.terminalWorker.terminal(task: .sourcery(try self.executor())).joined(separator: "\n"))")

                // 3. Revert Replace occurances

                self.signPost.verbose("🧙‍♂️ All files in Sources folders are reverted to status before generating protocols.")

                try fileSequences.forEach
                { fileSequence in
                    try self.replace(
                        in: fileSequence,
                        inline: (current: self.protocolGeneratableInline, replace: self.mockableInline),
                        end: (current: self.protocolGeneratalbeEnd, replace: self.mockableEnd)
                    )
                }

                // 4. Run sourcery to generate the mocks

                self.signPost.verbose("🧙‍♂️ Generating Mocks for newly generated protocols and refreshing old mocks.")
                let sourceryWorkerOutput = try self.terminalWorker.terminal(task: .sourcery(try self.executor()))

                // 6. Add imports to output

                try self.sourcery.outputFolder.makeFileSequence(recursive: true, includeHidden: false).forEach
                { file in
                    guard let _import = (self.sourcery.imports.first { file.name.hasPrefix($0.template) }) else { return }

                    var allLines = try file.readAllLines()

                    var importStatements = _import.names
                        .sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                        .map { $0.testable ? "@testable import \($0.name)" : "import \($0.name)" }

                    importStatements.append("\n")

                    allLines = importStatements + allLines

                    guard let data = (allLines.joined(separator: "\n").data(using: .utf8)) else { return }

                    try file.write(data: data)
                }

                guard let swiftFormatWorker = self.swiftFormatWorker else
                {
                    self.signPost.verbose("🧙‍♂️ \(self) \(#function) no swiftformat worker. Provide one if you want swiftformat to run on generated code.")
                    async { sourceryWorkerOutput }
                    return
                }

                self.signPost.verbose("🧙‍♂️ \(self) \(#function) has a swiftformat worker. Will run on autogenerated code from config file in that folder.")

                swiftFormatWorker.attempt
                { syncOutput in
                    async
                    {
                        try syncOutput()
                        return sourceryWorkerOutput
                    }
                }
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
            guard file.extension == "swift", file.path != #file else { return }

            let content = try file.readAsString()
                .replacingOccurrences(of: inline.current, with: inline.replace)
                .replacingOccurrences(of: end.current, with: end.replace)
            try file.write(string: content, encoding: .utf8)
        }
    }
}
