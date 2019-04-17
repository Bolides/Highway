//
//  SignPostPackages.swift
//  SPRunner
//
//  Created by Stijn Willems on 13/03/2019.
//

import Arguments
import Errors
import Foundation
import GitHooks
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

public protocol HighwayProtocol: AutoMockable
{
    // sourcery:inline:Highway.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }
    var package: PackageProtocol { get }
    var sourceryBuilder: SourceryBuilderProtocol { get }
    var sourceryWorkers: [SourceryWorkerProtocol] { get set }
    var queue: HighwayDispatchProtocol { get }
    var githooks: GitHooksWorkerProtocol? { get }
    var swiftformat: SwiftFormatWorkerProtocol { get }
    var highwaySetupExecutableName: String? { get }

    func dependency(with name: String) throws -> DependencyProtocol
    func gitHooks() throws -> FolderProtocol
    func srcRoot() throws -> FolderProtocol
    func templateFolder() throws -> FolderProtocol
    func templateFolder(expectedName: String) throws -> FolderProtocol
    func sourceryFolder() throws -> FolderProtocol
    func sourceryAutoProtocolFile() throws -> FileProtocol
    // sourcery:end

    static func package(for folder: FolderProtocol, dependencyService: DependencyServiceProtocol, dumpService: DumpService, terminal: TerminalProtocol, signPost: SignPostProtocol) throws -> PackageProtocol
}

public protocol PackageProtocol: AutoMockable
{
    // sourcery:inline:Highway.Package.AutoGenerateProtocol
    var name: String { get }
    var dependencies: DependencyProtocol { get }
    var dump: DumpProtocol { get }
    // sourcery:end
}

public struct Highway: HighwayProtocol, AutoGenerateProtocol
{
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.highway")

    public struct Package: PackageProtocol, AutoGenerateProtocol
    {
        public let name: String
        public let dependencies: DependencyProtocol
        public let dump: DumpProtocol
    }

    public let package: PackageProtocol
    public let sourceryBuilder: SourceryBuilderProtocol
    public var sourceryWorkers: [SourceryWorkerProtocol]
    public let queue: HighwayDispatchProtocol
    public let githooks: GitHooksWorkerProtocol?
    public let swiftformat: SwiftFormatWorkerProtocol

    // If set to nil the only executable in the package will be used
    public let highwaySetupExecutableName: String?

    // MARK: - STATIC - Generate Packages for Folders

    // sourcery:skipProtocol
    public static func package(for folder: FolderProtocol, dependencyService: DependencyServiceProtocol, dumpService: DumpService, terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared) throws -> PackageProtocol
    {
        signPost.message("📦 \(folder.name) ...")

        let dependencies = try dependencyService.generateDependency()
        let highwayPackage = Highway.Package(
            name: folder.name,
            dependencies: dependencies,
            dump: try dumpService.generateDump()
        )
        signPost.message("📦 \(folder.name) ✅")
        return highwayPackage
    }

    // MARK: - Init

    public init(
        package: PackageProtocol,
        dependencyService: DependencyServiceProtocol,
        sourceryBuilder: SourceryBuilderProtocol,
        githooksOption: Set<GitHooksWorker.Option> = Set(CommandLine.arguments.compactMap { GitHooksWorker.Option(rawValue: $0) }), // By default this takes arguments from command line and sees if they match anything usefull for GithookwWorker
        highwaySetupExecutableName: String? = nil, // If set to nil the only product with type executable will be chosen
        githooksPrePushScriptOptions: String? = nil, // Will be added after git hooks pre push script
        swiftformatType: SwiftFormatWorkerProtocol.Type = SwiftFormatWorker.self,
        githooksType: GitHooksWorkerProtocol.Type? = GitHooksWorker.self, // if set to nil githooks will not be added
        sourceryWorkerType: SourceryWorkerProtocol.Type = SourceryWorker.self,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = Highway.queue,
        sourceryType: SourceryProtocol.Type = Sourcery.self
    ) throws
    {
        self.highwaySetupExecutableName = highwaySetupExecutableName
        self.queue = queue
        self.package = package

        signPost.verbose("\(package)")

        self.sourceryBuilder = sourceryBuilder

        let dump = package.dump
        let dependencies = package.dependencies
        let products = dump.products.filter { !$0.name.hasSuffix("Mock") }

        let sourceryModels: [SourceryProtocol] = try products
            .map
        { product in
            try sourceryType.init(
                productName: product.name,
                swiftPackageDependencies: dependencies,
                swiftPackageDump: dump,
                sourceryBuilder: sourceryBuilder,
                signPost: signPost
            )
        }

        let srcRoot = try package.dependencies.srcRoot()
        sourceryWorkers = sourceryModels.map { sourceryWorkerType.init(sourcery: $0, terminal: terminal, signPost: signPost, queue: queue) }

        githooks = githooksType?.init(
            swiftPackageDependencies: package.dependencies,
            swiftPackageDump: package.dump,
            commandlineOptions: githooksOption,
            hwSetupExecutableProductName: highwaySetupExecutableName,
            prePushScriptCommandlineOptions: githooksPrePushScriptOptions,
            gitHooksFolder: try srcRoot.subfolder(named: ".git/hooks"),
            signPost: signPost
        )

        swiftformat = try swiftformatType.init(
            folderToFormatRecursive: srcRoot,
            queue: queue,
            signPost: signPost
        )
    }

    // MARK: - Public Functions

    public func dependency(with name: String) throws -> DependencyProtocol
    {
        guard let dependency = (package.dependencies.dependencies.first { $0.name == name }) else
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: Error.missingDepencencyNamed(name))
        }

        return dependency
    }

    public func gitHooks() throws -> FolderProtocol
    {
        return try srcRoot().subfolder(named: ".git/hooks")
    }

    public func srcRoot() throws -> FolderProtocol
    {
        return try package.dependencies.srcRoot()
    }

    /// Will look for package named "template-sourcery"
    public func templateFolder() throws -> FolderProtocol
    {
        return try package.dependencies.templateFolder()
    }

    public func templateFolder(expectedName: String) throws -> FolderProtocol
    {
        return try package.dependencies.templateFolder(expectedName: expectedName)
    }

    public func sourceryFolder() throws -> FolderProtocol
    {
        return try package.dependencies.sourceryFolder()
    }

    public func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        return try package.dependencies.sourceryAutoProtocolFile()
    }

    // MARK: - Error

    public enum Error: Swift.Error
    {
        case missingDepencencyNamed(String)
    }
}
