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
    func attempt() throws -> [String]
   /// sourcery:end
    
}

public struct SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol {
    
    private let sourcery: SourceryProtocol
    private let signPost: SignpostProtocol
    private let terminalWorker: TerminalWorkerProtocol
    
    struct Error: Swift.Error {
        let message: String
    }
    
    public init(sourcery: SourceryProtocol, terminalWorker: TerminalWorkerProtocol = TerminalWorker(), signPost: SignpostProtocol = HighwaySignpost.shared) throws {
        self.sourcery = sourcery
        self.terminalWorker = terminalWorker
        self.signPost = signPost
    }
    
    public func executor() throws -> ArgumentExecutableProtocol {
        return SourceryExecutor(sourcery)
    }
    
    public func attempt() throws -> [String] {

        // To generate mocks correctly we have to do a text replacement and run sourcery twice
        
        // Replace /// sourcery:inline: with /// sourcery:inline:
        // Replace /// sourcery:end with /// sourcery:end
        
        signPost.log("🧙‍♂️ All files in sources folders will be scanned for occurrences of `/// sourcery:` and replaced with `/// sourcery:` to be able generate protocols.")
        // 1. Find all files in sourceFolder
        
        var fileSequences = [FileSystemSequence<File>]()
        
        for folder in sourcery.sourcesFolders {
            let fileSequence = folder.makeFileSequence(recursive: true, includeHidden: false)
            
            // 2. Replace occurances
            
            try fileSequence.forEach { file in
                
                guard file.extension == "swift", file.path != #file else { return }
                
                let content = try file.readAsString()
                    .replacingOccurrences(of: "/// sourcery:inline:", with: "// sourcery:inline:")
                    .replacingOccurrences(of: "/// sourcery:end", with: "// sourcery:end")
                try file.write(string: content)
            }
            
            fileSequences.append(fileSequence)
        }
       
        // 3. Run sourcery to generate the protocols
        signPost.log("🧙‍♂️ Generating protocols")
        
        let output = try terminalWorker.terminal(task: .sourcery(try executor()))
        signPost.verbose("🧙‍♂️ \(output.joined(separator: "\n"))")

        // Replace // sourcery:inline: with /// sourcery:inline:
        // Replace // sourcery:end with /// sourcery:end

        // 4. Revert Replace occurances
        signPost.log("🧙‍♂️ All files in sources folders are reverted to status before generating protocols.")
        
        try fileSequences.forEach { fileSequence in

            try fileSequence.forEach { file in
                guard file.extension == "swift", file.path != #file else { return }
                
                let content = try file.readAsString()
                    .replacingOccurrences(of: "// sourcery:inline:", with: "/// sourcery:inline:")
                    .replacingOccurrences(of: "// sourcery:end", with: "/// sourcery:end")
                try file.write(string: content)
            }
           
        }

        // 5. Run sourcery to generate the mocks
        signPost.log("🧙‍♂️ Generating Mocks for newly generated protocols and refreshing old mocks.")
        
        return try terminalWorker.terminal(task: .sourcery(try executor()))
    }
    
}
