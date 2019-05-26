//
//  SwiftPackage.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Errors
import Foundation
import SourceryAutoProtocols
import ZFile

public protocol DumpProtocol: AutoMockable
{
    // sourcery:inline:SwiftPackageDump.AutoGenerateProtocol
    var products: Set<SwiftProduct> { get }
    var targets: Set<SwiftTarget> { get }
    // sourcery:end
}

public struct Dump: Decodable, DumpProtocol, CustomStringConvertible
{
    public let products: Set<SwiftProduct>
    public let targets: Set<SwiftTarget>

    // sourcery:skipProtocol
    public var description: String
    {
        return """
        \(Dump.self)
        
        Products
        \(products.map { $0.description }.joined(separator: "\n"))
        
        Targets
         \(targets.map { $0.description }.joined(separator: "\n"))
        
        """
    }
}
