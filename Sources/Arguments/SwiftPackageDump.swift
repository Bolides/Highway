//
//  SwiftPackage.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Foundation
import SourceryAutoProtocols
import ZFile
import Errors

public protocol SwiftPackageDumpProtocol: AutoMockable {
    // sourcery:inline:SwiftPackage.AutoGenerateProtocol
    var products: Set<SwiftProduct> { get }
    // sourcery:end
}

public struct SwiftPackageDump: Decodable, SwiftPackageDumpProtocol, CustomStringConvertible {
    
    public let products: Set<SwiftProduct>
    
    public var description: String {
        return """
        \(SwiftPackageDump.self)
        
        // TODO
        
        """
    }

}
