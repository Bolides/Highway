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
import Task
import Terminal
import ZFile

public protocol SourceryBuilderProtocol: AutoMockable
{
    /// sourcery:inline:SourceryBuilder.AutoGenerateProtocol
    static var buildPath: String { get }
    static var executalbeName: String { get }

    func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    /// sourcery:end
}

/// Will build sourcery from carthage if it is not found in the project
public struct SourceryBuilder: SourceryBuilderProtocol, AutoGenerateProtocol
{
    public static let buildPath: String = ".build/release"
    public static let executalbeName: String = "sourcery"

    private let terminalWorker: TerminalWorkerProtocol
    private let disk: DiskProtocol
    private let signPost: SignPostProtocol
    private let systemExecutableProvider: SystemExecutableProviderProtocol

    /// Will try to init Disk when no dis provided
    public init(
        terminalWorker: TerminalWorkerProtocol = TerminalWorker(),
        disk: DiskProtocol? = nil,
        signPost: SignPostProtocol = SignPost.shared,
        systemExecutableProvider: SystemExecutableProviderProtocol = SystemExecutableProvider.shared
    ) throws
    {
        self.terminalWorker = terminalWorker
        self.signPost = signPost
        self.systemExecutableProvider = systemExecutableProvider

        guard let disk = disk else
        {
            self.disk = try Disk()
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
                let swiftBuildTask = Task(executable: try systemExecutableProvider.executable(with: "swift"))

                swiftBuildTask.arguments = Arguments(["build", "-c", "release"])

                signPost.verbose("cd \(disk.carthage.sourcery)")
                FileManager.default.changeCurrentDirectoryPath(disk.carthage.sourcery.path)

                signPost.message("🚀 Start building sourcery (😅 this can take some time ☕️) ...")

                let output = try terminalWorker.runProcess(swiftBuildTask.toProcess)
                signPost.verbose("\(output.joined(separator: "\n"))")

                signPost.message("🚀 finished sourcery swift build ✅")

                signPost.verbose("cd \(disk.srcRoot)")
                FileManager.default.changeCurrentDirectoryPath(disk.srcRoot.path)

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
        return try disk.carthage.sourcery.subfolder(named: SourceryBuilder.buildPath).file(named: SourceryBuilder.executalbeName)
    }
}
