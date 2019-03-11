//
//  SwiftTarget.swift
//  TerminalTests
//
//  Created by Stijn Willems on 11/03/2019.
//

import Foundation

import SourceryAutoProtocols

public protocol SwiftTargetProtocol: AutoMockable
{
    // sourcery:inline:SwiftTarget.AutoGenerateProtocol
    var name: String { get }
    var dependencies: Set<SwiftProduct> { get }
    // sourcery:end
}

public struct SwiftTarget: SwiftTargetProtocol, Decodable, AutoGenerateProtocol, Hashable
{
    public let name: String
    public let dependencies: Set<SwiftProduct>

    public init(
        name: String,
        dependencies: Set<SwiftProduct>
    )
    {
        self.name = name
        self.dependencies = dependencies
    }
}
