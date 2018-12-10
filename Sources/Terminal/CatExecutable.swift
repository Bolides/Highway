//
//  CatExecutable.swift
//  GitHooks
//
//  Created by Stijn on 17/07/2018.
//

import Foundation
import Task
import Arguments

#if ZBotFramework

import ZBotInput
import ZFile

#endif

struct CatExecutable: ArgumentExecutableProtocol {

    let _argument: Arguments
    
    func executableFile() throws -> FileProtocol {
        return try File(path: "/bin/cat")
    }
    
    func arguments() throws -> Arguments {
        return _argument
    }
    
    
}
