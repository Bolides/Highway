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
    // highway:inline:SwiftPackage.AutoGenerateProtocol
    var products: Set<SwiftProduct> { get }
    // highway:end
}

public struct SwiftPackageDump: Decodable, SwiftPackageDumpProtocol, CustomStringConvertible
{
    public let products: Set<SwiftProduct>

    public var description: String
    {
        return """
        \(SwiftPackageDump.self)
        
        // TODO
        
        """
    }
}
