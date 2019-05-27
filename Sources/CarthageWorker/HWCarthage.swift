//
//  Carthage.swift
//  AutomateBolides
//
//  Created by Stijn on 05/03/2019.
//  Copyright © 2019 AutomateBolides. All rights reserved.
//

import Foundation

import Errors
import HighwayLibrary
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

    func attemptRunCarthageIfCommandLineOptionAdded(in folder: FolderProtocol, _ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    // sourcery:end
}

public struct HWCarthage: HWCarthageProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.HWCarthage")

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let dispatchGroup: HWDispatchGroupProtocol
    private let queue: HighwayDispatchProtocol
    private let carthageBuilder: CarthageBuilderProtocol
    private let options: Set<CommandLineOption>

    // MARK: - Commandline Options

    public enum CommandLineOption: String, CaseIterable, Hashable, Equatable
    {
        case carhageUpdateNoBuild
    }

    // MARK: - Init

    public init(
        dispatchGroup: HWDispatchGroupProtocol,
        carthageBuilder: CarthageBuilderProtocol,
        options: Set<CommandLineOption> = Set(CommandLine.arguments.compactMap { CommandLineOption(rawValue: $0) }),
        queue: HighwayDispatchProtocol = HWCarthage.queue,
        signPost: SignPostProtocol = SignPost.shared,
        terminal: TerminalProtocol = Terminal.shared
    )
    {
        self.signPost = signPost
        self.terminal = terminal
        self.dispatchGroup = dispatchGroup
        self.queue = queue
        self.carthageBuilder = carthageBuilder
        self.options = options
    }

    // MARK: - Public functions

    public func attemptRunCarthageIfCommandLineOptionAdded(in folder: FolderProtocol, _ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        guard options.contains(.carhageUpdateNoBuild) else
        {
            signPost.message("⚠️ ignore \(pretty_function()) because no \(CommandLineOption.carhageUpdateNoBuild) added to commandline")
            return
        }

        dispatchGroup.enter()
        queue.async
        {
            do
            {
                let carthageExecutable = try self.carthageBuilder.attemptBuildCarthageIfNeeded()
                let carthage = Task(executable: carthageExecutable).toProcess
                carthage.currentDirectoryPath = folder.path
                carthage.arguments = ["update", "--no-build"]

                let output = try self.terminal.runProcess(carthage)

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
