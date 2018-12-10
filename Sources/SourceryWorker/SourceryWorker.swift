//
//  SourceryWorker.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Foundation
import os
import SourceryAutoProtocols
import Task
import Terminal
import ZFile


public protocol SourceryWorkerProtocol {
    
    /// sourcery:inline:SourceryWorker.AutoGenerateProtocol
    func executor() throws -> ArgumentExecutableProtocol
   /// sourcery:end
    
}

public struct SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol {
    
    private let sourcery: SourceryProtocol

    private let terminalWorker: TerminalWorkerProtocol
    
    struct Error: Swift.Error {
        let message: String
    }
    
    init(sourcery: SourceryProtocol, terminalWorker: TerminalWorkerProtocol = TerminalWorker()) {
        self.sourcery = sourcery
        self.terminalWorker = terminalWorker
    }
    
    public func executor() throws -> ArgumentExecutableProtocol {
        return SourceryExecutor(sourcery)
    }
    
    public func attempt() throws -> [String] {

        // To generate mocks correctly we have to do a text replacement and run sourcery twice
        
        // Replace /// sourcery:inline: with /// sourcery:inline:
        // Replace /// sourcery:end with /// sourcery:end
        
        // 1. Find all files in sourceFolder
        
        let allSwiftFiles = sourcery.sourceFolder.makeFileSequence(recursive: true, includeHidden: false)
        
        // 2. Replace occurances
        
        try allSwiftFiles.forEach { file in
            
            guard file.extension == "swift", file.path != #file else { return }
            
            let content = try file.readAsString()
                .replacingOccurrences(of: "/// sourcery:inline:", with: "// sourcery:inline:")
                .replacingOccurrences(of: "/// sourcery:end", with: "// sourcery:end")
            try file.write(string: content)
        }
        
        // 3. Run sourcery to generate the protocols

        let output = try terminalWorker.terminal(task: .sourcery(try executor()))
        os_log("%@", type:.debug, output.joined(separator: "\n"))

        // Replace /// sourcery:inline: with /// sourcery:inline:
        // Replace /// sourcery:end with /// sourcery:end

        // 4. Replace occurances

        try allSwiftFiles.forEach { file in

            guard file.extension == "swift", file.path != #file else { return }

            let content = try file.readAsString()
                .replacingOccurrences(of: "// sourcery:inline:", with: "/// sourcery:inline:")
                .replacingOccurrences(of: "// sourcery:end", with: "/// sourcery:end")
            try file.write(string: content)
        }

        // 5. Run sourcery to generate the mocks

        return try terminalWorker.terminal(task: .sourcery(try executor()))
    }
    
}
