//
//  SwiftFormatWorker.swift
//  SwiftformatWorker
//
//  Created by Stijn on 03/01/2019.
//

import SourceryAutoProtocols
import SwiftFormat
import os
import ZFile

public protocol SwiftFormatWorkerProtocol: AutoMockable {
    /// sourcery:inline:SwiftformatWorker.AutoGenerateProtocol

    func attempt() throws 
    /// sourcery:end
}

public struct SwiftFormatWorker: SwiftFormatWorkerProtocol, AutoGenerateProtocol {
    
    private let folderToFormat: FolderProtocol
    private let configFile: FileProtocol
    
    public init(folderToFormat: FolderProtocol, configFile: FileProtocol) {
        self.folderToFormat = folderToFormat
        self.configFile = configFile
    }
    
    public func attempt() throws {
        CLI.print = { message, type in
            switch type {
            case .info:
                os_log(.info, "💁🏻‍♂️ \n%@\n", message)
            case .success:
                os_log(.info, "💁🏻‍♂️ \n%@\n", message)
            case .error:
                os_log(.error, "🌋 \n%@\n", message)
            case .warning:
                os_log(.debug, "⚠️ \n%@\n", message)
            case .content:
                os_log(.info, "💁🏻‍♂️ \n%@\n", message)
            }
        }
        
        do {
            
            let folder = try Folder(path: "/Users/doozmen/Documents/dooZ/Babylon/ios-babylon-application/Sources/Demo/Sources")
            let config = try folder.file(named: ".swiftformat.md")
            print(">> Starting in \(folder.path)...")
            
            let arguments = ["--config", config.path]
            let result = CLI.run(in: folder.path, with: arguments)
            
            print("result:\n\(result)\n")
            print(">> ✅")
            
        } catch {
            print(error)
        }
        

    }
}
