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

public protocol DumpServiceProtocol: AutoMockable
{
    // sourcery:inline:DumpService.AutoGenerateProtocol
    var dump: DumpProtocol { get }

    init(
        terminal: TerminalWorkerProtocol,
        swiftPackageDependencies: DependencyProtocol
    ) throws
    func writeToStubFile() throws
    // sourcery:end
}

public struct DumpService: DumpServiceProtocol, AutoGenerateProtocol
{
    public let dump: DumpProtocol

    private let swiftPackageDependencies: DependencyProtocol
    private let data: Data

    // sourcery:includeInitInProtocol
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared, swiftPackageDependencies: DependencyProtocol) throws
    {
        self.swiftPackageDependencies = swiftPackageDependencies
        let task = try Task(commandName: "swift")
        task.arguments = Arguments(["package", "dump-package"])

        let output: String = try terminal.runProcess(task.toProcess).joined()
        data = output.data(using: .utf8)!

        dump = try JSONDecoder().decode(Dump.self, from: data)
    }

    public func writeToStubFile() throws
    {
        let stubFile = try swiftPackageDependencies.srcRoot().subfolder(named: "Sources/Stub").createFileIfNeeded(named: "\(DumpService.self).json")
        try stubFile.write(data: data)
    }
}
