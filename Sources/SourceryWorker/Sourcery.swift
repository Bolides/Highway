//
//  File.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Foundation
import SourceryAutoProtocols
import Task
import ZFile
import Terminal
import os

public protocol SourceryProtocol: ExecutableProtocol {
    
    /// sourcery:inline:Sourcery.AutoGenerateProtocol
    var templateFolder: FolderProtocol { get }
    var outputFolder: FolderProtocol { get }
    var sourcesFolders: [FolderProtocol] { get }
    var sourceryAutoProtocolsFile: FileProtocol { get }
    var sourceryYMLFile: FileProtocol { get }
    var imports: Set<Import> { get }

   /// sourcery:end
    
}

public struct Sourcery: SourceryProtocol, AutoGenerateProtocol {
    public let templateFolder: FolderProtocol
    public let outputFolder: FolderProtocol
    public let sourcesFolders: [FolderProtocol]
    public let sourceryAutoProtocolsFile: FileProtocol
    public let sourceryYMLFile: FileProtocol
    public let imports: Set<Import>

    public struct ExecutableNotFoundError: Swift.Error, CustomDebugStringConvertible {
        let message: String
        let originalError: Error
        
        init(_ originalError: Error) {
            message = """
            
            🧙‍♂️ ExecutableNotFoundError
            
            You should install sourcery in your application folder by building it from source.
            Instructions on how to do that can be found https://github.com/krzysztofzablocki/Sourcery
            
            After that is done move the applition to the application folder so GitHooks can execute task
            
            `/Applications/Sourcery.app/Contents/MacOS/Sourcery`
            
            """
            self.originalError = originalError
        }
        
        public var debugDescription: String {
            return message
        }
    }
    
    public init (
        sourcesFolders: [FolderProtocol],
        templateFolder: FolderProtocol,
        outputFolder: FolderProtocol,
        sourceryAutoProtocolsFile: FileProtocol,
        sourceryYMLFile: FileProtocol,
        imports: Set<Import>
    ) throws  {
        self.templateFolder = templateFolder
        self.outputFolder = outputFolder
        self.sourcesFolders = sourcesFolders
        self.sourceryAutoProtocolsFile = sourceryAutoProtocolsFile
        self.sourceryYMLFile = sourceryYMLFile
        self.imports = imports
       
        // generate .sourcery file
        
        try sourceryYMLFile.write(
            string: """
            sources:
            \(sourcesFolders.map { "- \"\($0.path)\""}.joined(separator: "\n"))
            - "\(sourceryAutoProtocolsFile.path)"
            templates:
            - "\(templateFolder.path)"
            output:
             "\(outputFolder.path)"
            """,
            encoding:  .utf8
        )
        os_log("🧙‍♂️ Sourcery YML file can be found at path:\n %@\n", type:.debug, sourceryYMLFile.path)
    }
    
    // sourcery:skipProtocol
    public func executableFile() throws -> FileProtocol {
        do {
            return try SourceryExecutableFile()
        } catch {
            throw ExecutableNotFoundError(error)
        }
    }
    
}

