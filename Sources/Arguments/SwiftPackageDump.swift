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

public protocol SwiftPackageDumpProtocol: AutoMockable
{
    // sourcery:inline:SwiftPackage.AutoGenerateProtocol
    var products: Set<SwiftProduct> { get }
    var targets: Set<SwiftTarget> { get }
    // sourcery:end
}

public struct SwiftPackageDump: Decodable, SwiftPackageDumpProtocol, CustomStringConvertible
{
    public let products: Set<SwiftProduct>
    public let targets: Set<SwiftTarget>

    public var description: String
    {
        return """
        \(SwiftPackageDump.self)
        
        // TODO
        
        """
    }
}
