//
//  CommandLineOptions.swift
//  SignPost
//
//  Created by Stijn on 27/02/2019.
//

import Foundation

public enum SignPostCommandLineOptions: String, CaseIterable {
    case verbose
    case _verbose = "-verbose"
    case __verbose = "--verbose"
    
    public var isVerbose: Bool {
        switch self {
        case .verbose, .__verbose, ._verbose:
            return true
        }
    }
}
