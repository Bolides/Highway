//
//  ArgumentsWorker.swift
//  Arguments
//
//  Created by Stijn on 17/12/2018.
//

import Foundation
import SourceryAutoProtocols

public protocol ArgumentsWorkerProtocol: AutoMockable {
    /// sourcery:inline:ArgumentsWorker.AutoGenerateProtocol
    var workers: [Worker] { get }
    /// sourcery:end
}

public struct ArgumentsWorker: AutoGenerateProtocol {

    public let workers: [Worker]
    
    /// Reads arguments from command line and searches for workers.
    /// If none are found it throws `ArgumentsWorker.Error`
    public init() throws {
        workers = CommandLine.arguments
            .filter { $0.hasPrefix(Worker.commandPrefix) }
            .map { $0.replacingOccurrences(of: Worker.commandPrefix, with: "")}
            .compactMap { Worker(rawValue: $0) }
        
        guard workers.count > 0 else {
            throw Error.noWorkerCommandFoundInArguments
        }
        
    }
    // MARK: - ERROR
    
    public enum Error: Swift.Error {
        case noWorkerCommandFoundInArguments
    }
    
}
