//
//  Carthage.swift
//  AutomateBolides
//
//  Created by Stijn on 05/03/2019.
//  Copyright © 2019 AutomateBolides. All rights reserved.
//

import Foundation

import Errors
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol CarthageProtocol: AutoMockable
{
    // sourcery:inline:Carthage.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }

    func attemptCarthageUpdateNoBuild(in folder: FolderProtocol, _ async: @escaping (@escaping Carthage.SyncOutput) -> Void)

    // sourcery:end
}

public struct Carthage: CarthageProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.HWCarthage")

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol
    private let dispatchGroup: HWDispatchGroupProtocol
    private let queue: HighwayDispatchProtocol
    private let system: SystemProtocol

    // MARK: - Init

    public init(
        dispatchGroup: HWDispatchGroupProtocol,
        queue: HighwayDispatchProtocol = Carthage.queue,
        signPost: SignPostProtocol = SignPost.shared,
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.signPost = signPost
        self.terminal = terminal
        self.dispatchGroup = dispatchGroup
        self.queue = queue
        self.system = system
    }

    // MARK: - Public functions

    public func attemptCarthageUpdateNoBuild(in folder: FolderProtocol, _ async: @escaping (@escaping Carthage.SyncOutput) -> Void)
    {
        dispatchGroup.enter()
        queue.async
        {
            do
            {
                let carthage = try self.system.installOrGetProcessFromBrew(formula: "carthage", in: folder)
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
