//
//  SourceryExecutableFile.swift
//  SourceryWorker
//
//  Created by Stijn on 17/12/2018.
//

import Foundation
import SourceryAutoProtocols
import ZFile

// sourcery:AutoMockable
// sourcery:mockInherit = FileProtocolMock
// sourcery:skipPublicInit
public protocol SourceryExecutableFileProtocol: FileProtocol
{
    // highway:inline:SourceryExecutableFile.AutoGenerateProtocol
    // highway:end
}

public class SourceryExecutableFile: File, SourceryExecutableFileProtocol, AutoGenerateProtocol
{
    required init(path: String) throws
    {
        try super.init(path: path)
    }

    required init() throws
    {
        try super.init(path: "/Applications/Sourcery.app/Contents/MacOS/Sourcery")
    }
}
