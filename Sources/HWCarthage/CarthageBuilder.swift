//
//  CarthageBuilder.swift
//  CleanCheckoutFramework
//
//  Created by Stijn Willems on 19/03/2019.
//

import Errors
import Foundation
import Highway
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol CarthageBuilderProtocol: AutoMockable
{
    // sourcery:inline:CarthageBuilder.AutoGenerateProtocol
    static var carthageExecutablePath: String { get }

    func attemptBuildCarthageIfNeeded() throws -> FileProtocol

    // sourcery:end
}

/// Will build carthage in the .build folder if not installed
public struct CarthageBuilder: CarthageBuilderProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> FileProtocol
    public static let carthageExecutablePath: String = "./.build/x86_64-apple-macosx10.10/release/carthage"

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let highway: HighwayProtocol
    private let system: SystemProtocol

    // MARK: - Init

    public init(
        highway: HighwayProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.highway = highway
        self.system = system
    }

    // MARK: - Public Funtions

    public func attemptBuildCarthageIfNeeded() throws -> FileProtocol
    {
        guard (highway.package.package.dependencies.dependencies.first { $0.name == "Carthage" }) != nil else
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: Error.missingCarthageDepencyInPackage)
        }

        do
        {
            let carthageExecutable = try File(path: CarthageBuilder.carthageExecutablePath)
            return carthageExecutable
        }
        catch FileSystem.Item.PathError.invalid(_)
        {
            // Build carthage

            let originalDirectory = FileSystem.shared.currentFolder
            let srcRoot = try highway.package.package.dependencies.srcRoot()

            FileManager.default.changeCurrentDirectoryPath(srcRoot.path)

            signPost.message("🚀 \(pretty_function()) (😅 this can take some time ☕️) ...")
            let task = try system.process("swift")
            task.arguments = ["build", "--product", "Carthage", "-c", "release", "--static-swift-stdlib"]

            let output = try terminal.runProcess(task)

            signPost.verbose("\(output.joined(separator: "\n"))")

            signPost.message("🚀 \(pretty_function()) ✅")

            FileManager.default.changeCurrentDirectoryPath(originalDirectory.path)

            return try File(path: CarthageBuilder.carthageExecutablePath)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Error

    public enum Error: Swift.Error
    {
        case missingCarthageDepencyInPackage
    }
}
