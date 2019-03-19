//
//  PodInstallWorker.swift
//  AutomateBolides
//
//  Created by Stijn on 27/02/2019.
//  Copyright © 2019 AutomateBolides. All rights reserved.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol PodInstallWorkerProtocol: AutoMockable
{
    // sourcery:inline:PodInstallWorker.AutoGenerateProtocol
    static var expectedCocoapodsVersion: String { get }

    func attempt() throws
    // sourcery:end
}

public struct PodInstallWorker: PodInstallWorkerProtocol, AutoGenerateProtocol
{
    public static let expectedCocoapodsVersion: String = "1.5.3"

    private let terminal: TerminalProtocol
    private let system: SystemExecutableProviderProtocol
    private let signPost: SignPostProtocol
    private let reactNativeRootFolder: FolderProtocol

    public init(
        reactNativeRootFolder: FolderProtocol,
        system: SystemExecutableProviderProtocol = SystemExecutableProvider.shared,
        terminalWorker: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        terminal = terminalWorker
        self.system = system
        self.signPost = signPost
        self.reactNativeRootFolder = reactNativeRootFolder
    }

    public func attempt() throws
    {
        let originalFolder = FileSystem.shared.currentFolder
        let iosFolder = try reactNativeRootFolder.subfolder(named: "ios")
        FileManager.default.changeCurrentDirectoryPath(iosFolder.path)

        // MARK: - Check cocoapods version

        signPost.message("\(pretty_function()) in folder: \(iosFolder.name) ...")
        signPost.message("check cocoapods version")

        let versionTask = try Task(commandName: "pod").toProcess
        versionTask.arguments = ["--version"]
        let versionOutput = try terminal.runProcess(versionTask)

        guard let version = versionOutput.first, version == PodInstallWorker.expectedCocoapodsVersion else
        {
            throw Error.invalidCocoapodsVersion
        }

        do
        {
            signPost.message("run `pod install`...")

            let task = try Task(commandName: "pod").toProcess
            task.arguments = ["_\(PodInstallWorker.expectedCocoapodsVersion)_", "install"]

            let output = try terminal.runProcess(task)
            FileManager.default.changeCurrentDirectoryPath(originalFolder.path)

            signPost.verbose("\(output)")
            signPost.message("\(pretty_function()) ✅")
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public enum Error: Swift.Error, CustomStringConvertible
    {
        public var description: String
        {
            return """
            Please uninstall your pod version via
            
            ``` bash
            sudo gem uninstall cocoapods
            sudo gem install cocoapods -v "\(PodInstallWorker.expectedCocoapodsVersion)"
            ```
            
            then try again
            """
        }

        case invalidCocoapodsVersion
    }
}
