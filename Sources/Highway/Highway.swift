//
//  SignPostPackages.swift
//  SPRunner
//
//  Created by Stijn Willems on 13/03/2019.
//

import Arguments
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
    var sourceryWorkers: [SourceryWorkerProtocol] { get }
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
    public let sourceryWorkers: [SourceryWorkerProtocol]
    public let queue: HighwayDispatchProtocol
    public let githooks: GitHooksWorkerProtocol?
    public let swiftformat: SwiftFormatWorkerProtocol

    // MARK: - STATIC - Generate Packages for Folders

    public static func package(for folder: FolderProtocol, terminal: TerminalProtocol = Terminal.shared) throws -> PackageProtocol
    {
        let originalFolder = FileSystem.shared.currentFolder
        FileManager.default.changeCurrentDirectoryPath(folder.path)

        let dependencies = try DependencyService(terminal: terminal).dependency
        let highwayPackage = Highway.Package(
            name: folder.name,
            dependencies: dependencies,
            dump: try DumpService(terminal: terminal, swiftPackageDependencies: dependencies).dump
        )
        FileManager.default.changeCurrentDirectoryPath(originalFolder.path)
        return highwayPackage
    }

    // MARK: - Init

    public init(
        package: (package: PackageProtocol, executable: String),
        swiftformatType: SwiftFormatWorkerProtocol.Type = SwiftFormatWorker.self,
        githooksType: GitHooksWorkerProtocol.Type? = GitHooksWorker.self, // if set to nil githooks will not be added
        sourceryWorkerType: SourceryWorkerProtocol.Type = SourceryWorker.self,
        sourceryBuilderType: SourceryBuilderProtocol.Type = SourceryBuilder.self,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = Highway.queue,
        sourceryType: SourceryProtocol.Type = Sourcery.self
    ) throws
    {
        self.queue = queue
        signPost.message("📦 \(Highway.self) ...")

        self.package = package

        let builder = try sourceryBuilderType.init(terminalWorker: terminal, disk: package.package.dependencies, signPost: signPost, systemExecutableProvider: SystemExecutableProvider())
        sourceryBuilder = builder
        let sourcery = try builder.attemptToBuildSourceryIfNeeded()

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
                sourceryExecutable: sourcery,
                signPost: signPost
            )
        }
        sourceryWorkers = try sourceryModels.map { try sourceryWorkerType.init(sourcery: $0, terminalWorker: terminal, signPost: signPost, queue: queue) }

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
