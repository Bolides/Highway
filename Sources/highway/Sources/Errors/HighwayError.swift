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
    
    // MARK: - CustomStringConvertible

    public var description: String
    {
        switch self {
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
        }
    }
}
