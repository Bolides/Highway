//
//  SwiftPackageService.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Arguments
import Foundation
import SourceryAutoProtocols
import ZFile

public protocol SwiftPackageDumpServiceProtocol: AutoMockable
{
    // sourcery:inline:SwiftPackageDumpService.AutoGenerateProtocol
    var swiftPackageDump: SwiftPackageDumpProtocol { get }

    func writeToStubFile() throws
    // sourcery:end
}

public struct SwiftPackageDumpService: SwiftPackageDumpServiceProtocol, AutoGenerateProtocol
{
    public let swiftPackageDump: SwiftPackageDumpProtocol

    private let swiftPackageDependencies: SwiftPackageDependenciesProtocol
    private let data: Data

    // sourcery:includeInitInprotocol
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared, swiftPackageDependencies: SwiftPackageDependenciesProtocol) throws
    {
        self.swiftPackageDependencies = swiftPackageDependencies
        let task = try Task(commandName: "swift")
        task.arguments = Arguments(["package", "dump-package"])

        let output: String = try terminal.runProcess(task.toProcess).joined()
        data = output.data(using: .utf8)!

        swiftPackageDump = try JSONDecoder().decode(SwiftPackageDump.self, from: data)
    }

    public func writeToStubFile() throws
    {
        let stubFile = try swiftPackageDependencies.srcRoot().subfolder(named: "Sources/Stub").createFileIfNeeded(named: "\(SwiftPackageDumpService.self).json")
        try stubFile.write(data: data)
    }
}
