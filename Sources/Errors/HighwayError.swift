//
//  HighwayError.swift
//  Errors
//
//  Created by Stijn on 27/02/2019.
//

import Foundation

public enum HighwayError: Swift.Error, CustomStringConvertible
{
    case missingSrcroot(message: String, function: String)
    case implement(String)
    case failedToCompleteTask(String)
    case processInfoMissingPath(processInfo: [String: String])
    case missingTemplateFolder(String)
    case prematureRelease(in: String)

    // MARK: - CustomStringConvertible

    public var description: String
    {
        switch self
        {
        case let .missingSrcroot(message: message, function: function):
            return """
            ❌ Highway Error in
                \(function)
            with message
                \(message)
            ❌
            """
        case let .implement(function):
            return """
            ❌ Highway Missing implementation in
                \(function)
            ❌
            """
        case let .failedToCompleteTask(task):
            return """
            ❌ Highway Failed to complete task
                \(task)
            ❌
            """
        case let .processInfoMissingPath(processInfo):
            return """
            ❌ Highway Failed processInfoMissingPath
            \(processInfo)
            ❌
            """
        case let .missingTemplateFolder(location):
            return """
            ❌ Highway Failed missingTemplateFolder
                add `.package(url: "https://www.github.com/doozMen/template-sourcery", from: "1.2.0")`
                to Package.swift
            
            > thrown in
            
                \(location)
            
            """
        case let .prematureRelease(in: location):
            return """
            ❌ Highway Failed prematureRelease(in:)
                ℹ️ You should retain any workers that do asynchronous work
            
            > thrown in
            
            \(location)
            
            """
        }
    }
}
