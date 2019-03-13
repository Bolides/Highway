//
//  SignPostPackages.swift
//  SPRunner
//
//  Created by Stijn Willems on 13/03/2019.
//

import Foundation
import SourceryAutoProtocols
import Terminal
import Arguments
import SignPost
import ZFile
import SourceryWorker
import HighwayDispatch

public protocol HighwayProtocol: AutoMockable {
    // sourcery:inline:Packages.AutoGenerateProtocol
    var packages: [Highway.Package] { get }
    var srcRootDependencies: DependencyProtocol { get }
    var sourceryBuilder: SourceryBuilderProtocol { get }
    var sourceryWorkers: [SourceryWorkerProtocol] { get }
    var queue: HighwayDispatchProtocol { get }
    // sourcery:end
}

public protocol PackageProtocol: AutoMockable {
    // sourcery:inline:SignPostPackages.Package.AutoGenerateProtocol
    var name: String { get }
    var dependencies: DependencyProtocol { get }
    var dump: DumpProtocol { get }
    // sourcery:end
}

public struct Highway: HighwayProtocol, AutoGenerateProtocol {
    
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.highway")
    
    public struct Package: PackageProtocol, AutoGenerateProtocol {
        public let name: String
        public let dependencies: DependencyProtocol
        public let dump: DumpProtocol
    }
    
    public let packages: [Highway.Package]
    public let srcRootDependencies: DependencyProtocol
    public let sourceryBuilder: SourceryBuilderProtocol
    public let sourceryWorkers: [SourceryWorkerProtocol]
    public let queue: HighwayDispatchProtocol
    
    public init(srcRootDependencies: DependencyProtocol,
                folders: [FolderProtocol],
                sourceryWorkerType: SourceryWorkerProtocol.Type = SourceryWorker.self,
                sourceryBuilderType: SourceryBuilderProtocol.Type = SourceryBuilder.self,
                terminal: TerminalWorkerProtocol = TerminalWorker.shared,
                signPost: SignPostProtocol = SignPost.shared,
                queue: HighwayDispatchProtocol = Highway.queue
    ) throws {
        self.queue = queue
        self.srcRootDependencies = srcRootDependencies
        signPost.message("📦 \(Highway.self) ...")
        
        var packages = [Highway.Package]()

        // Generate Packages for Folders
        
         try folders.forEach { srcRoot in
            FileManager.default.changeCurrentDirectoryPath(srcRoot.path)
            
            let spHighWayDependencies = try DependencyService(terminal: terminal).dependency
            let spHighwaySetupPackage = Highway.Package(
                name: srcRoot.name,
                dependencies: spHighWayDependencies,
                dump: try DumpService(terminal: terminal, swiftPackageDependencies: spHighWayDependencies).dump
            )
            packages.append(spHighwaySetupPackage)
        }
        
        signPost.message("""
            📦 \(Highway.self) for
            \(try packages.map { "  * \(try $0.dependencies.srcRoot().path)" }.joined(separator: "\n"))
            ✅
            """
        )
        self.packages = packages
        
        let builder = try sourceryBuilderType.init(terminalWorker: terminal, disk: srcRootDependencies, signPost: signPost, systemExecutableProvider: SystemExecutableProvider())
        self.sourceryBuilder = builder
        let sourcery = try builder.attemptToBuildSourceryIfNeeded()
        
        let temp: [[SourceryWorkerProtocol]] = try packages
            .compactMap { package in
                let products = package.dump.products.filter { !$0.name.hasSuffix("Mock") }
                
                let sourceryModels: [SourceryProtocol] = try products
                    .map { product in
                        return try Sourcery(
                            productName: product.name,
                            swiftPackageDependencies: package.dependencies,
                            swiftPackageDump: package.dump,
                            sourceryExecutable: sourcery
                        )
                }
                return try sourceryModels.map { return try sourceryWorkerType.init(sourcery: $0, terminalWorker: terminal, signPost: signPost, queue: queue) }
        }
        self.sourceryWorkers = temp.flatMap { $0 }
    }
    
}
