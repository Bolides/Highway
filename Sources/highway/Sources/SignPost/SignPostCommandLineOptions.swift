//
//  CommandLineOptions.swift
//  SignPost
//
//  Created by Stijn on 27/02/2019.
//

import Foundation

public enum SignPostCommandLineOptions: String, CaseIterable
{
    case verbose
    case _verbose = "-verbose"
    case __verbose = "--verbose"

    public enum SingleOption: String {
        case verbose
    }
    
    public var isVerbose: Bool
    {
        switch self {
        case .verbose, .__verbose, ._verbose:
            return true
        }
    }
    
    public var signleOption: SingleOption
    {
        switch self {
        case .verbose, .__verbose, ._verbose:
            return .verbose
        }
    }
    
    public struct Values: CustomStringConvertible {
        
        public let all: [SingleOption]
        
        public init(commandLineArguments: [String] = CommandLine.arguments) {
            all = commandLineArguments.compactMap { SignPostCommandLineOptions(rawValue: $0)?.signleOption }
        }
        
        public var description: String {
            return """
            \(SignPostCommandLineOptions.Values.self)
            
            \(all.map { "   * \($0)"}.joined(separator:"\n"))
            
            """
        }

    }
}
