//
//  SourceryBuilder.swift
//  SourceryWorker
//
//  Created by Stijn on 28/02/2019.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol SourceryBuilderProtocol: AutoMockable
{
    // sourcery:inline:SourceryBuilder.AutoGenerateProtocol
    static var executalbeFolderPath: String { get }

    func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    // sourcery:end
}

/// Will build sourcery from carthage if it is not found in the project
public struct SourceryBuilder: SourceryBuilderProtocol, AutoGenerateProtocol
{
    public static let executalbeFolderPath: String = "./.build/x86_64-apple-macosx10.10/release"

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let system: SystemProtocol
    private let dependencyService: DependencyServiceProtocol

    /// Will try to init Disk when no dis provided
    public init(
        dependencyService: DependencyServiceProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.system = system
        self.dependencyService = dependencyService
    }

    public func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        let dependency = try dependencyService.generateDependency()

        do
        {
            return try dependency.srcRoot().subfolder(named: SourceryBuilder.executalbeFolderPath).file(named: "Sourcery")
        }
        catch ZFile.FileSystem.Item.PathError.invalid
        {
            signPost.verbose("Sourcery not build yet because of invalid path.\n Building sourcery from source with `swift build -c release`")

            do
            {
                let srcRoot = try dependency.srcRoot()

                signPost.message("🚀 \(pretty_function()) (😅 this can take some time ☕️) ...")
                let task = try system.process("swift")
                task.arguments = ["build", "--product", "Sourcery", "-c", "release", "--static-swift-stdlib"]
                task.currentDirectoryPath = srcRoot.path

                let output = try terminal.runProcess(task)

                signPost.message("\(output.joined(separator: "\n"))")

                signPost.message("🚀 \(pretty_function()) ✅")

                signPost.verbose("cd \(srcRoot)")

                return try dependency.srcRoot().subfolder(named: SourceryBuilder.executalbeFolderPath).file(named: "Sourcery")
            }
            catch
            {
                throw "\(self) \(#function) \n\(error)\n"
            }
        }
    }
}
