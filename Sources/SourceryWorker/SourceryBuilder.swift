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

public protocol SourceryBuilderProtocol: class, AutoMockable
{
    // sourcery:inline:SourceryBuilder.AutoGenerateProtocol
    static var executalbeFolderPath: String { get }

    func templateFolder() throws -> FolderProtocol
    func sourceryAutoProtocolFile() throws -> FileProtocol
    func dependencies() throws -> DependencyProtocol
    func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    // sourcery:end
}

/**
 Will build sourcery from carthage if it is not found in the project
*/
public class SourceryBuilder: SourceryBuilderProtocol, AutoGenerateProtocol
{
    public static let executalbeFolderPath: String = "./.build/x86_64-apple-macosx10.10/release"

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let system: SystemProtocol
    private let dependencyService: DependencyServiceProtocol
    private var dependency: DependencyProtocol?

    // MARK: - Init

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

    // MARK: - Public functions

    public func templateFolder() throws -> FolderProtocol
    {
        return try dependencies().templateFolder()
    }

    public func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        return try dependencies().sourceryAutoProtocolFile()
    }

    public func dependencies() throws -> DependencyProtocol
    {
        guard let dependency = dependency else
        {
            self.dependency = try dependencyService.generateDependency()
            return self.dependency!
        }

        return dependency
    }

    public func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        let dependency = try dependencies()

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
                throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
            }
        }
    }
}
