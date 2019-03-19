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
    static var executalbeName: String { get }

    init(
        swiftPackageWithSourceryFolder: FolderProtocol,
        terminal: TerminalProtocol,
        signPost: SignPostProtocol,
        system: SystemProtocol
    )
    func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    // sourcery:end
}

/// Will build sourcery from carthage if it is not found in the project
public struct SourceryBuilder: SourceryBuilderProtocol, AutoGenerateProtocol
{
    public static let executalbeName: String = "./.build/x86_64-apple-macosx10.10/release/Sourcery"

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let system: SystemProtocol
    private let swiftPackageWithSourceryFolder: FolderProtocol

    /// Will try to init Disk when no dis provided
    // sourcery:includeInitInProtocol
    public init(
        swiftPackageWithSourceryFolder: FolderProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.system = system
        self.swiftPackageWithSourceryFolder = swiftPackageWithSourceryFolder
    }

    public func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        let dependency = try DependencyService.generateDepedency(in: swiftPackageWithSourceryFolder, terminal: terminal, signPost: signPost).dep
        do
        {
            return try findSourceryExecutableFile()
        }
        catch ZFile.FileSystem.Item.PathError.invalid
        {
            signPost.verbose("Sourcery not build yet because of invalid path.\n Building sourcery from source with `swift build -c release`")

            do
            {
                let originalDirectory = FileSystem.shared.currentFolder
                let srcRoot = try dependency.srcRoot()

                FileManager.default.changeCurrentDirectoryPath(srcRoot.path)

                signPost.message("🚀 Start building sourcery (😅 this can take some time ☕️) ...")
                let task = try system.process("swift")
                task.arguments = ["build", "--product", "Sourcery", "-c", "release", "--static-swift-stdlib"]

                let output = try terminal.runProcess(task)

                signPost.message("\(output.joined(separator: "\n"))")

                signPost.message("🚀 finished sourcery swift build ✅")

                signPost.verbose("cd \(srcRoot)")

                FileManager.default.changeCurrentDirectoryPath(originalDirectory.path)

                return try findSourceryExecutableFile()
            }
            catch
            {
                throw "\(self) \(#function) \n\(error)\n"
            }
        }
    }

    // MARK: Private

    private func findSourceryExecutableFile() throws -> FileProtocol
    {
        return try swiftPackageWithSourceryFolder.file(named: SourceryBuilder.executalbeName)
    }
}
