//
//  GitExecutableCommitDescribe.swift
//  GitHooks
//
//  Created by Stijn on 17/07/2018.
//

import Foundation
import Task
import Arguments
import ZFile


public struct GitBranchName: ArgumentExecutableProtocol {
    
    public init() {}
    
    public func executableFile() throws -> FileProtocol {
        return try File(path: "/usr/bin/git")
    }
    
    public func arguments() throws -> Arguments {
        return Arguments(arrayLiteral: "describe", "--contains", "--all", "HEAD")
    }

}

public struct GitRootFolder: ArgumentExecutableProtocol {
    
    public init() {}
    
    public func executableFile() throws -> FileProtocol {
        return try File(path: "/usr/bin/git")
    }
    
    public func arguments() throws -> Arguments {
        return Arguments(arrayLiteral: "rev-parse", "--show-toplevel")
    }
    
}
