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
    case highwayError(atLocation: String, error: Swift.Error)
    case swiftPackageShowDependencies(String)

    // MARK: - CustomStringConvertible

    public var description: String
    {
        switch self
        {
        case let .missingSrcroot(message: message, function: function):
            return """
            missingSrcroot
                \(function)
            with message
                \(message)
            """
        case let .implement(function):
            return """
            implement
                \(function)
            """
        case let .failedToCompleteTask(task):
            return """
            failedToCompleteTask
                \(task)
            """
        case let .processInfoMissingPath(processInfo):
            return """
            processInfoMissingPath
            \(processInfo)
            """
        case let .missingTemplateFolder(error):
            return """
            missingTemplateFolder
                ℹ️ add `.package(url: "https://www.github.com/doozMen/template-sourcery", from: "1.2.0")`
                to Package.swift
            
            \(error)
            """
        case let .prematureRelease(in: location):
            return """
            ❌ Highway Failed prematureRelease(in:)
                ℹ️ You should retain any workers that do asynchronous work
            
            > thrown in
            
            \(location)
            
            """
        case let .highwayError(atLocation, error):
            return """
            ❌ highwayError
            location
            \(atLocation)
            
            error

            \(error)
            """
        case let .swiftPackageShowDependencies(message):
            return """
            swiftPackageShowDependencies
            
            \(message)
            """
        }
    }
}
