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
    static var carthageExecutableFolderPath: String { get }

    func attemptBuildCarthageIfNeeded() throws -> FileProtocol

    // sourcery:end
}

/// Will build carthage in the .build folder if not installed
public struct CarthageBuilder: CarthageBuilderProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> FileProtocol
    public static let carthageExecutableFolderPath: String = "./.build/x86_64-apple-macosx10.10/release"
    public static let carthageExecutableName: String = "carthage"
    
    // MARK: - Private

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let carthagePackage: PackageProtocol
    private let system: SystemProtocol

    // MARK: - Init

    public init(
        carthagePackage: PackageProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.carthagePackage = carthagePackage
        self.system = system
    }

    // MARK: - Public Funtions

    public func attemptBuildCarthageIfNeeded() throws -> FileProtocol
    {
        guard (carthagePackage.dump.products.first { $0.name == CarthageBuilder.carthageExecutableName }) != nil else
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: Error.missingCarthageDepencyInPackage)
        }

        do
        {
            let carthageExecutable = try carthagePackage.dependencies.srcRoot().subfolder(named: CarthageBuilder.carthageExecutableFolderPath).file(named: "carthage")
            return carthageExecutable
        }
        catch FileSystem.Item.PathError.invalid(_)
        {
            // Build carthage

            let srcRoot = try carthagePackage.dependencies.srcRoot()

            signPost.message("🚀 \(pretty_function()) (😅 this can take some time ☕️) ...")
            let task = try system.process("swift")
            task.arguments = ["build", "--product", CarthageBuilder.carthageExecutableName, "-c", "release", "--static-swift-stdlib"]
            task.currentDirectoryPath = srcRoot.path
            let output = try terminal.runProcess(task)

            signPost.verbose("\(output.joined(separator: "\n"))")

            signPost.message("🚀 \(pretty_function()) ✅")

            return try carthagePackage.dependencies.srcRoot().subfolder(named: CarthageBuilder.carthageExecutableFolderPath).file(named: "carthage")
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
