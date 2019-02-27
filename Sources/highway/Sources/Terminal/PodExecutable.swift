//
//  PodExecutable.swift
//  Terminal
//
//  Created by Stijn on 27/02/2019.
//

import Foundation
import Arguments
import ZFile

public struct PodExecutable: ArgumentExecutableProtocol
{
    
    public init()
    {
    }
    
    public func arguments() throws -> Arguments
    {
        return Arguments(arrayLiteral: "install")
    }
    
    public func executableFile() throws -> FileProtocol
    {
        let homeFolder = FileSystem.shared.homeFolder
        return try homeFolder.file(named: ".rbenv/shims/pod")
    }
}
