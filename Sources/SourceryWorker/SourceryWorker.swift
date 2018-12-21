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
import SignPost

public protocol SourceryWorkerProtocol {
    
    /// sourcery:inline:SourceryWorker.AutoGenerateProtocol
    func executor() throws -> ArgumentExecutableProtocol
    func attempt() throws -> [String]
   /// sourcery:end
    
}

/// To generate mocks correctly we have to do a text replacement and run sourcery twice.
/// This worker will perform the following tasks
/// 1. Find all files in sourceFolder
/// 1.1 (Optional) Replace also in individual files
/// 2. Run sourcery to generate the protocols
/// 3. Revert Replace occurances
/// 4. Run sourcery to generate the mocks
/// 6. Add imports to output
public struct SourceryWorker: SourceryWorkerProtocol, AutoGenerateProtocol {
    
    private let sourcery: SourceryProtocol
    private let signPost: SignPostProtocol
    private let terminalWorker: TerminalWorkerProtocol
    
    private let mockableInline =  "/// sourcery:inline:"
    private let mockableEnd = "/// sourcery:end"
    private let protocolGeneratableInline = "// sourcery:inline:"
    private let protocolGeneratalbeEnd = "// sourcery:end"
    
    struct Error: Swift.Error {
        let message: String
    }
    
    public init(sourcery: SourceryProtocol, terminalWorker: TerminalWorkerProtocol = TerminalWorker(), signPost: SignPostProtocol = SignPost.shared) throws {
        self.sourcery = sourcery
        self.terminalWorker = terminalWorker
        self.signPost = signPost
    }
    
    public func executor() throws -> ArgumentExecutableProtocol {
        return SourceryExecutor(sourcery)
    }
    
    public func attempt() throws -> [String] {

        signPost.verbose("🧙‍♂️ All files in sources folders will be scanned for occurrences of `/// sourcery:` and replaced with `/// sourcery:` to be able generate protocols.")
        
        // 1. Find all files in sourceFolder and Replace occurances of inline with 3 slashes
        
        var fileSequences = [AnySequence<File>]()
        
        for folder in sourcery.sourcesFolders {
            let fileSequence = folder.makeFileSequence(recursive: true, includeHidden: false)
            
            try replace(
                in: AnySequence(fileSequence),
                inline: (current: mockableInline, replace: protocolGeneratableInline),
                end: (current: mockableEnd, replace: protocolGeneratalbeEnd)
            )
            
            fileSequences.append(AnySequence(fileSequence))
        }
        
        // 1.1 (Optional) Replace also in individual files
        
        if let individualFiles = sourcery.individualSourceFiles {
            
            let individualFileSequence = AnySequence(individualFiles)
            
            try replace(
                in: individualFileSequence,
                inline: (current: mockableInline, replace: protocolGeneratableInline),
                end: (current: mockableEnd, replace: protocolGeneratalbeEnd)
            )
            
            fileSequences.append(individualFileSequence)
        }
       
        // 2. Run sourcery to generate the protocols
        
        signPost.verbose("🧙‍♂️ Generating protocols")
        
        signPost.verbose("🧙‍♂️ \(try terminalWorker.terminal(task: .sourcery(try executor())).joined(separator: "\n"))")

        // 3. Revert Replace occurances
        
        signPost.verbose("🧙‍♂️ All files in sources folders are reverted to status before generating protocols.")
        
        try fileSequences.forEach { fileSequence in

            try replace(
                in: fileSequence,
                inline: (current: protocolGeneratableInline, replace: mockableInline),
                end: (current: protocolGeneratalbeEnd, replace: mockableEnd)
            )
           
        }

        // 4. Run sourcery to generate the mocks
        
        signPost.verbose("🧙‍♂️ Generating Mocks for newly generated protocols and refreshing old mocks.")
        let output = try terminalWorker.terminal(task: .sourcery(try executor()))
        
        // 6. Add imports to output
        
        try sourcery.outputFolder.makeFileSequence(recursive: true, includeHidden: false).forEach { file in
            
            guard let _import = (sourcery.imports.first { file.name.hasPrefix($0.template) }) else { return }
            
            var allLines = try file.readAllLines()
            
            var importStatements = _import.names.map { $0.testable ? "@testable import \($0.name)": "import \($0.name)"}
            importStatements.append("\n")
            
            allLines = importStatements + allLines
            
            guard let data = (allLines.joined(separator: "\n").data(using: .utf8)) else { return }
            
            try file.write(data: data)
            
        }

        return output
    }
    
    // MARK: - Private
    
    private func replace(in fileSequence: AnySequence<File>, inline: (current: String, replace: String), end: (current: String, replace: String)) throws {
        
        try fileSequence.forEach { file in
            
            guard file.extension == "swift", file.path != #file else { return }
            
            let content = try file.readAsString()
                .replacingOccurrences(of: inline.current, with: inline.replace)
                .replacingOccurrences(of: end.current, with: end.replace)
            try file.write(string: content, encoding: .utf8)
        }
    }
    
}
