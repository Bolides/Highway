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

public protocol SourceryProtocol: ExecutableProtocol {
    
    /// sourcery:inline:Sourcery.AutoGenerateProtocol
    var templateFolder: FolderProtocol { get }
    var outputFolder: FolderProtocol { get }
    var sourceFolder: FolderProtocol { get }
   
   /// sourcery:end
    
}

public struct Sourcery: SourceryProtocol, AutoGenerateProtocol {
    public let templateFolder: FolderProtocol
    public let outputFolder: FolderProtocol
    public let sourceFolder: FolderProtocol

    
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
        templateFolder: FolderProtocol,
        outputFolder: FolderProtocol,
        sourceFolder: FolderProtocol
    ) throws  {
        self.templateFolder = templateFolder
        self.outputFolder = outputFolder
        self.sourceFolder = sourceFolder
    }
    
    // sourcery:skipProtocol
    public func executableFile() throws -> FileProtocol {
        do {
            return try File(path: "/Applications/Sourcery.app/Contents/MacOS/Sourcery")
        } catch {
            throw ExecutableNotFoundError(error)
        }
    }
    
}
