//
//  XCBuildDestinations.swift
//  XCBuild
//
//  Created by Stijn on 01/03/2019.
//

import Foundation
import Errors

import SourceryAutoProtocols

public protocol XCBuildDestinationsProtocol: AutoMockable {
    // sourcery:inline:XCBuildDestinations.AutoGenerateProtocol
    // sourcery:end
}

public struct  XCBuildDestinations: XCBuildDestinationsProtocol, AutoGenerateProtocol {
    
    let platform: Destination.Platform
    let id: String
    let name: String
    let os: Destination.OS
    
    init(destinationString: String) throws {
        throw HighwayError.implement("\(XCBuildDestinations.self) \(#function)")
    }
}
