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

    /// Will throw HWPod.Error that you can choose to ignore
    public func attempt() throws
    {
        let iosFolder = podFolder
        
        // MARK: - Check cocoapods version
        
        signPost.message("\(pretty_function()) in folder: \(iosFolder.name) ...")
        signPost.message("check cocoapods version")
        
        var versionTask: ProcessProtocol!
        
        do {
           versionTask = try system.process("pod")
        } catch {
            throw Error.systemHasNoPodInstalled
        }
        
        versionTask.arguments = ["--version"]
        let versionOutput = try terminal.runProcess(versionTask)
        signPost.verbose("\(versionOutput.joined(separator: "\n"))")
        
        guard let version = versionOutput.first, version == HWPod.expectedCocoapodsVersion else
        {
            throw Error.invalidCocoapodsVersion
        }
        
        do
        {
            signPost.message("run `pod install`...")
            
            let task = try system.process("pod")
            task.arguments = ["_\(HWPod.expectedCocoapodsVersion)_", "install"]
            task.currentDirectoryPath = iosFolder.path
            
            let output = try terminal.runProcess(task)
            
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
        case systemHasNoPodInstalled
    }
}
