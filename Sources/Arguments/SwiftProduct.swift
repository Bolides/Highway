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
    // sourcery:end
}

public struct SwiftProduct: SwiftProductProtocol, Decodable, AutoGenerateProtocol, Hashable
{
    public let name: String
}
