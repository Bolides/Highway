//
//  SwiftPackageService.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Foundation
import Arguments
import SourceryAutoProtocols

public protocol SwiftPackageDumpServiceProtocol: AutoMockable {
    /// sourcery:inline:SwiftPackageDumpService.AutoGenerateProtocol
    /// sourcery:end
}

public struct SwiftPackageDumpService: SwiftPackageDumpServiceProtocol, AutoGenerateProtocol {
        
    public let swiftPackageDump: SwiftPackageDumpProtocol
    
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared) throws {
        let task = try Task(commandName: "swift")
        task.arguments = Arguments([ "package", "dump-package"])
        
        let output: String = try terminal.runProcess(task.toProcess).joined()
        let data: Data = output.data(using: .utf8)!
        
        swiftPackageDump = try JSONDecoder().decode(SwiftPackageDump.self, from: data)
    }
    
}
