//
//  DocumentationWorker.swift
//  Highway
//
//  Created by Stijn Willems on 22/05/2019.
//

import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol DocumentationWorkerProtocol: AutoMockable
{
    // sourcery:inline:DocumentationWorker.AutoGenerateProtocol

    func attemptJazzyDocs(in folder: FolderProtocol) throws -> [String]
    // sourcery:end
}

public struct DocumentationWorker: DocumentationWorkerProtocol, AutoGenerateProtocol
{
    // MARK: - Private

    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol

    // MARK: - Init

    public init(
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.terminal = terminal
        self.system = system
        self.signPost = signPost
    }

    // MARK: - Attempt to generate Docs

    public func attemptJazzyDocs(in folder: FolderProtocol) throws -> [String]
    {
        do
        {
            signPost.message("\(pretty_function()) checking ruby install ...")
            let rbenv = try system.rbenvProcess(in: folder)
            rbenv.arguments = ["install", "-l"]

            let rbenvOutput = try terminal.runProcess(rbenv)
            signPost.message("\(rbenvOutput.joined(separator: "\n")) ")
            signPost.message("\(pretty_function()) checking ruby install ✅")

            signPost.verbose("\(pretty_function()) ...")

            let jazzy = try system.installOfFindGem(name: "jazzy", in: folder)

            let output = try terminal.runProcess(jazzy)
            signPost.message("\(pretty_function()) ✅")

            return output
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
