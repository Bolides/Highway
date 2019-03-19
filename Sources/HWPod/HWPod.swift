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

public protocol HWPodProtocol: AutoMockable
{
    // sourcery:inline:HWPod.AutoGenerateProtocol
    static var expectedCocoapodsVersion: String { get }

    func attempt() throws
    // sourcery:end
}

public struct HWPod: HWPodProtocol, AutoGenerateProtocol
{
    public static let expectedCocoapodsVersion: String = "1.5.3"

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let podFolder: FolderProtocol
    private let fileSystem: FileSystemProtocol
    private let system: SystemProtocol

    public init(
        podFolder: FolderProtocol,
        strictPodVersion: String = HWPod.expectedCocoapodsVersion,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        fileSystem: FileSystemProtocol = FileSystem.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.podFolder = podFolder
        self.fileSystem = fileSystem
        self.system = system
    }

    public func attempt() throws
    {
        let originalFolder = FileSystem.shared.currentFolder
        let iosFolder = podFolder
        FileManager.default.changeCurrentDirectoryPath(iosFolder.path)

        // MARK: - Check cocoapods version

        signPost.message("\(pretty_function()) in folder: \(iosFolder.name) ...")
        signPost.message("check cocoapods version")

        let versionTask = try system.process("pod")
        versionTask.arguments = ["--version"]
        let versionOutput = try terminal.runProcess(versionTask)

        guard let version = versionOutput.first, version == HWPod.expectedCocoapodsVersion else
        {
            throw Error.invalidCocoapodsVersion
        }

        do
        {
            signPost.message("run `pod install`...")

            let task = try system.process("pod")
            task.arguments = ["_\(HWPod.expectedCocoapodsVersion)_", "install"]

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
            sudo gem install cocoapods -v "\(HWPod.expectedCocoapodsVersion)"
            ```
            
            then try again
            """
        }

        case invalidCocoapodsVersion
    }
}
