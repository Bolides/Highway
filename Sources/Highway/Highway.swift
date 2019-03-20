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
    // sourcery:inline:Packages.AutoGenerateProtocol
    var package: (package: PackageProtocol, executable: String) { get }
    var sourceryBuilder: SourceryBuilderProtocol { get }
    var sourceryWorkers: [SourceryWorkerProtocol] { get set }
    var queue: HighwayDispatchProtocol { get }
    var githooks: GitHooksWorkerProtocol? { get }
    var swiftformat: SwiftFormatWorkerProtocol { get }
    // sourcery:end
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

    public let package: (package: PackageProtocol, executable: String)
    public let sourceryBuilder: SourceryBuilderProtocol
    public var sourceryWorkers: [SourceryWorkerProtocol]
    public let queue: HighwayDispatchProtocol
    public let githooks: GitHooksWorkerProtocol?
    public let swiftformat: SwiftFormatWorkerProtocol

    // MARK: - STATIC - Generate Packages for Folders

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

    // Will setup Highway in folder of srcRootDependencies and optionaly in the extra folders provided
    public init(
        package: (package: PackageProtocol, executable: String),
        extraFolders: [FolderProtocol]? = nil, // Packages in these folders will be created
        dependencyService: DependencyServiceProtocol,
        swiftformatType: SwiftFormatWorkerProtocol.Type = SwiftFormatWorker.self,
        githooksType: GitHooksWorkerProtocol.Type? = GitHooksWorker.self, // if set to nil githooks will not be added
        sourceryWorkerType: SourceryWorkerProtocol.Type = SourceryWorker.self,
        sourceryBuilder: SourceryBuilderProtocol,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = Highway.queue,
        sourceryType: SourceryProtocol.Type = Sourcery.self
    ) throws
    {
        self.queue = queue
        self.package = package

        signPost.message(
            """
            📦 \(pretty_function()) for
            \(try package.package.dependencies.srcRoot())
            ✅
            """
        )
        signPost.verbose("\(package)")

        self.sourceryBuilder = sourceryBuilder

        let dump = package.package.dump
        let dependencies = package.package.dependencies
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

        sourceryWorkers = sourceryModels.map { sourceryWorkerType.init(sourcery: $0, terminal: terminal, signPost: signPost, queue: queue) }

        githooks = githooksType?.init(
            swiftPackageDependencies: package.package.dependencies,
            swiftPackageDump: package.package.dump,
            hwSetupExecutableProductName: package.executable,
            gitHooksFolder: try package.package.dependencies.srcRoot().subfolder(named: ".git/hooks"),
            signPost: signPost
        )

        swiftformat = try swiftformatType.init(
            folderToFormatRecursive: try package.package.dependencies.srcRoot(),
            queue: queue,
            signPost: signPost
        )
    }
}
