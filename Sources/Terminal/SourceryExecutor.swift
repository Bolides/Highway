//
//  SourceryExecutor.swift
//  🤖
//
//  Created by Stijn on 22/07/2018.
//

import Foundation

import Task
import Arguments


#if ZBotFramework

import ZBotInput
import ZFile

#endif

struct SourceryExecutor: ArgumentExecutableProtocol {
    
    private let sourcery: SourceryProtocol
    
    init(_ sourcery: SourceryProtocol) {
        self.sourcery = sourcery
    }
    
    func executableFile() throws -> FileProtocol {
        return try sourcery.executableFile()
    }
    
    // sourcery:skipProtocol
    public func arguments() throws -> Arguments {
        return Arguments(arrayLiteral:
                "--templates", self.sourcery.templateFolder.path,
                "--output", self.sourcery.outputFolder.path,
                "--sources", self.sourcery.sourceFolder.path
        )
    }
}
