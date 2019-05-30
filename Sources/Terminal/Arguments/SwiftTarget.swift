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
    var path: String? { get }
    var dependencies: Set<SwiftTarget.Dependency> { get }
    // sourcery:end
}

public struct SwiftTarget: SwiftTargetProtocol, Decodable, AutoGenerateProtocol, Hashable, CustomStringConvertible
{
    public let name: String
    public let path: String?
    public let dependencies: Set<SwiftTarget.Dependency>

    public struct Dependency: Decodable, Hashable, CustomStringConvertible
    {
        public let name: String

        public var description: String
        {
            return """
            \(Dependency.self)
            * name: \(name)
            """
        }
    }

    public init(
        name: String,
        path: String? = nil,
        dependencies: Set<SwiftTarget.Dependency>
    )
    {
        self.name = name
        self.dependencies = dependencies
        self.path = nil
    }

    // sourcery:skipProtocol
    public var description: String
    {
        return """
        \(SwiftTarget.self)
        * name: \(name)
        * dependencies:
        \(dependencies.map { "  * \($0).description" }.joined(separator: "\n"))
        """
    }
}
