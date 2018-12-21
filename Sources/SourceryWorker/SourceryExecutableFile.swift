//
//  SourceryExecutableFile.swift
//  SourceryWorker
//
//  Created by Stijn on 17/12/2018.
//

import Foundation
import ZFile
import SourceryAutoProtocols

public protocol SourceryExecutableFileProtocol: FileProtocol, AutoMockable {
    /// sourcery:inline:SourceryExecutableFile.AutoGenerateProtocol
    /// sourcery:end
}

public class SourceryExecutableFile: File, SourceryExecutableFileProtocol, AutoGenerateProtocol {
    
    required init(path: String) throws {
       try super.init(path: path)
    }
    
    required init() throws {
        try super.init(path: "/Applications/Sourcery.app/Contents/MacOS/Sourcery")
    }
    
}
