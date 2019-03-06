//
//  SourceryBuilder.swift
//  SourceryWorker
//
//  Created by Stijn on 28/02/2019.
//

import Arguments
import Errors
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile
import Foundation

public protocol SourceryBuilderProtocol: AutoMockable
{
    /// sourcery:inline:SourceryBuilder.AutoGenerateProtocol
    static var executalbeName: String { get }

    func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    /// sourcery:end
}

/// Will build sourcery from carthage if it is not found in the project
public struct SourceryBuilder: SourceryBuilderProtocol, AutoGenerateProtocol
{
    public static let executalbeName: String = "./.build/x86_64-apple-macosx10.10/release/Sourcery"

    private let terminalWorker: TerminalWorkerProtocol
    private let disk: SwiftPackageProtocol
    private let signPost: SignPostProtocol
    private let systemExecutableProvider: SystemExecutableProviderProtocol

    /// Will try to init Disk when no dis provided
    public init(
        terminalWorker: TerminalWorkerProtocol = TerminalWorker(),
        disk: SwiftPackageProtocol? = nil,
        signPost: SignPostProtocol = SignPost.shared,
        systemExecutableProvider: SystemExecutableProviderProtocol = SystemExecutableProvider.shared
    ) throws
    {
        self.terminalWorker = terminalWorker
        self.signPost = signPost
        self.systemExecutableProvider = systemExecutableProvider

        guard let disk = disk else
        {
            self.disk = try SwiftPackageDependencyService().swiftPackage
            return
        }

        self.disk = disk
    }

    public func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        do
        {
            return try findSourceryExecutableFile()
        }
        catch ZFile.FileSystem.Item.PathError.invalid
        {
            signPost.verbose("Sourcery not build yet because of invalid path.\n Building sourcery from source with `swift build -c release`")

            do
            {
    
                let srcRoot = try disk.srcRoot()
                
                FileManager.default.changeCurrentDirectoryPath(srcRoot.path)

                signPost.message("🚀 Start building sourcery (😅 this can take some time ☕️) ...")
                let task = try Task(commandName: "swift")
                task.arguments = Arguments(["build", "--product", "Sourcery", "-c", "release", "--static-swift-stdlib"])
                
                let output = try terminalWorker.runProcess(task.toProcess)
                
                signPost.message("\(output.joined(separator: "\n"))")

                signPost.message("🚀 finished sourcery swift build ✅")

                signPost.verbose("cd \(srcRoot)")
                
                FileManager.default.changeCurrentDirectoryPath(srcRoot.path)

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
        return try disk.srcRoot().file(named: SourceryBuilder.executalbeName)
    }
}
