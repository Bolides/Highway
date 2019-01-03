//
//  SwiftFormatWorker.swift
//  SwiftformatWorker
//
//  Created by Stijn on 03/01/2019.
//

import SourceryAutoProtocols
import Terminal

public protocol SwiftformatWorkerProtocol: AutoMockable {
    // sourcery:inline:SwiftformatWorker.AutoGenerateProtocol
    // sourcery:end
}

public struct SwiftformatWorker: SwiftformatWorkerProtocol, AutoGenerateProtocol {
    
    public init() { }
}
