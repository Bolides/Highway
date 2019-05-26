//
//  SwiftProduct.swift
//  Arguments
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

import SourceryAutoProtocols

public protocol SwiftProductProtocol: AutoMockable
{
    // sourcery:inline:SwiftProduct.AutoGenerateProtocol
    var name: String { get }
    var product_type: String { get }
    // sourcery:end
}

public struct SwiftProduct: SwiftProductProtocol, Decodable, AutoGenerateProtocol, Hashable, CustomStringConvertible
{
    public let name: String
    public let product_type: String

    public init(name: String, product_type: String)
    {
        self.name = name
        self.product_type = product_type
    }

    // sourcery:skipProtocol
    public var description: String
    {
        return """
        \(SwiftProduct.self)
        * name: \(name)
        * product_type: \(product_type)
        
        """
    }
}
