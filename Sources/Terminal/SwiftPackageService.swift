//
//  SwiftPackageService.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Foundation
import Arguments
import SourceryAutoProtocols

public protocol SwiftPackageServiceProtocol: AutoMockable {
    // sourcery:inline:SwiftPackageService .AutoGenerateProtocol
    // sourcery:end
}

public struct  SwiftPackageService: SwiftPackageServiceProtocol, AutoGenerateProtocol {
    
    public let swiftPackage: SwiftPackageProtocol
    
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared) throws {
        let task = try Task(commandName: "swift")
        task.arguments = Arguments(["package", "show-dependencies", "--format", "json"])
        
        let output: String = try terminal.runProcess(task.toProcess).joined()
        let data: Data = output.data(using: .utf8)!
        
        swiftPackage = try JSONDecoder().decode(SwiftPackage.self, from: data)
    }
    
}
