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
    var packages: [PackageProtocol] { get }
    var srcRootDependencies: DependencyProtocol { get }
    var sourceryBuilder: SourceryBuilderProtocol { get }
    var sourceryWorkers: [SourceryWorkerProtocol] { get }
    var queue: HighwayDispatchProtocol { get }
    var githooks: GitHooksWorkerProtocol { get }
    var swiftformat: SwiftFormatWorkerProtocol { get }
    // sourcery:end
}

public protocol PackageProtocol: AutoMockable
{
    // sourcery:inline:SignPostPackages.Package.AutoGenerateProtocol
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

    public let packages: [PackageProtocol]
    public let srcRootDependencies: DependencyProtocol
    public let sourceryBuilder: SourceryBuilderProtocol
    public let sourceryWorkers: [SourceryWorkerProtocol]
    public let queue: HighwayDispatchProtocol
    public let githooks: GitHooksWorkerProtocol
    public let swiftformat: SwiftFormatWorkerProtocol

    // MARK: - STATIC - Generate Packages for Folders

    public static func package<F>(for folder: FolderProtocol, terminal: TerminalWorkerProtocol, folderType: F.Type) throws -> Highway.Package where F: FolderProtocol
    {
        let originalFolder = FileSystem.shared.currentFolder
        FileManager.default.changeCurrentDirectoryPath(folder.path)

        let dependencies = try DependencyService(terminal: terminal, folderType: folderType).dependency
        let highwayPackage = Highway.Package(
            name: folder.name,
            dependencies: dependencies,
            dump: try DumpService(terminal: terminal, swiftPackageDependencies: dependencies).dump
        )
        FileManager.default.changeCurrentDirectoryPath(originalFolder.path)
        return highwayPackage
    }

    // MARK: - Init

    // Will setup Highway in folder of srcRootDependencies and optionaly in the extra folders provided
    public init<F>(
        srcRootDependencies: DependencyProtocol,
        extraFolders: [FolderProtocol]? = nil,
        highwaySetupProductName: String? = nil, // if nothing provided the name or the root package is taken
        swiftformatType: SwiftFormatWorkerProtocol.Type = SwiftFormatWorker.self,
        githooksType: GitHooksWorkerProtocol.Type = GitHooksWorker.self,
        sourceryWorkerType: SourceryWorkerProtocol.Type = SourceryWorker.self,
        sourceryBuilderType: SourceryBuilderProtocol.Type = SourceryBuilder.self,
        terminal: TerminalWorkerProtocol = TerminalWorker.shared,
        signPost: SignPostProtocol = SignPost.shared,
        queue: HighwayDispatchProtocol = Highway.queue,
        sourceryType: SourceryProtocol.Type = Sourcery.self,
        folderType: F.Type
    ) throws where F: FolderProtocol
    {
        self.queue = queue
        self.srcRootDependencies = srcRootDependencies
        signPost.message("📦 \(Highway.self) ...")

        var packages = [Highway.Package]()

        let rootPackage = try Highway.package(for: try srcRootDependencies.srcRoot(), terminal: terminal, folderType: folderType)

        packages.append(rootPackage)

        try extraFolders?.forEach { packages.append(try Highway.package(for: $0, terminal: terminal, folderType: folderType)) }

        signPost.message(
            """
            📦 \(Highway.self) for
            \(try packages.map { "  * \(try $0.dependencies.srcRoot().path)" }.joined(separator: "\n"))
            ✅
            """
        )
        self.packages = packages

        let builder = try sourceryBuilderType.init(terminalWorker: terminal, disk: srcRootDependencies, signPost: signPost, systemExecutableProvider: SystemExecutableProvider())
        sourceryBuilder = builder
        let sourcery = try builder.attemptToBuildSourceryIfNeeded()

        let temp: [[SourceryWorkerProtocol]] = try packages
            .compactMap
        { package in
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
                    sourceryExecutable: sourcery,
                    signPost: signPost
                )
            }
            return try sourceryModels.map { try sourceryWorkerType.init(sourcery: $0, terminalWorker: terminal, signPost: signPost, queue: queue) }
        }

        sourceryWorkers = temp.flatMap { $0 }

        githooks = githooksType.init(
            swiftPackageDependencies: rootPackage.dependencies,
            swiftPackageDump: rootPackage.dump,
            hwSetupExecutableProductName: highwaySetupProductName == nil ? rootPackage.name : highwaySetupProductName!,
            gitHooksFolder: try rootPackage.dependencies.srcRoot().subfolder(named: ".git/hooks"),
            signPost: signPost
        )
        swiftformat = try swiftformatType.init(
            folderToFormatRecursive: try rootPackage.dependencies.srcRoot(),
            queue: queue,
            signPost: signPost
        )
    }
}
