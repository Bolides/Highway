//
//  Carthage.swift
//  AutomateBolides
//
//  Created by Stijn on 05/03/2019.
//  Copyright © 2019 AutomateBolides. All rights reserved.
//

import Foundation

import Arguments
import Errors
import HighwayDispatch
import Result
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol HWCarthageProtocol: AutoMockable
{
    // sourcery:inline:HWCarthage.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }

    func attempt(_ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)

    // sourcery:end
}

public struct HWCarthage: HWCarthageProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.HWCarthage")

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let executableProvicer: SystemExecutableProviderProtocol
    private let srcRoot: FolderProtocol
    private let dispatchGroup: DispatchGroup
    private let queue: HighwayDispatchProtocol

    // MARK: - Init

    public init(
        srcRoot: FolderProtocol,
        dispatchGroup: DispatchGroup,
        carthageBuilder: CarthageBuilderProtocol,
        queue: HighwayDispatchProtocol = HWCarthage.queue,
        signPost: SignPostProtocol = SignPost.shared,
        terminal: TerminalProtocol = Terminal.shared,
        executableProvicer: SystemExecutableProviderProtocol = SystemExecutableProvider.shared
    )
    {
        self.signPost = signPost
        self.terminal = terminal
        self.executableProvicer = executableProvicer
        self.srcRoot = srcRoot
        self.dispatchGroup = dispatchGroup
        self.queue = queue
    }

    // MARK: - Public functions

    public func attempt(_ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        dispatchGroup.enter()
        queue.async
        {
            do
            {
                let carthage = try Task(commandName: "carthage").toProcess

                let currentFolder = FileSystem.shared.currentFolder
                FileManager.default.changeCurrentDirectoryPath(self.srcRoot.path)

                carthage.arguments = ["update", "--no-build"]

                let output = try self.terminal.runProcess(carthage)

                FileManager.default.changeCurrentDirectoryPath(currentFolder.path)
                async { output }
            }
            catch
            {
                async { throw HighwayError.highwayError(atLocation: pretty_function(), error: error) }
            }

            self.dispatchGroup.leave()
        }
    }
}
