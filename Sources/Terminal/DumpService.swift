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

    func generateDump() throws  -> DumpProtocol

    // sourcery:end
}

public struct DumpService: DumpServiceProtocol, AutoGenerateProtocol
{
    private let swiftPackageFolder: FolderProtocol
    private let system: SystemProtocol
    private let terminal: TerminalProtocol

    public init(swiftPackageFolder: FolderProtocol, system: SystemProtocol = System.shared, terminal: TerminalProtocol = Terminal.shared)
    {
        self.swiftPackageFolder = swiftPackageFolder
        self.terminal = terminal
        self.system = system
    }

    public func generateDump() throws -> DumpProtocol
    {
        let task = try system.process("swift")
        task.arguments = ["package", "dump-package"]
        task.currentDirectoryPath = swiftPackageFolder.path

        let output: String = try terminal.runProcess(task).joined()
        let data = output.data(using: .utf8)!

        return try JSONDecoder().decode(Dump.self, from: data)
    }
}
