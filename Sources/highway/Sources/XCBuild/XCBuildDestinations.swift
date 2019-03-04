//
//  XCBuildDestinations.swift
//  XCBuild
//
//  Created by Stijn on 01/03/2019.
//

import Errors
import Foundation

import SourceryAutoProtocols

public protocol XCBuildDestinationsProtocol: AutoMockable
{
    /// sourcery:inline:XCBuildDestinations.AutoGenerateProtocol
    var platform: Destination.Platform { get }
    var id: String { get }
    var name: String { get }
    var os: Destination.OS { get }
    /// sourcery:end
}

public struct XCBuildDestinations: XCBuildDestinationsProtocol, AutoGenerateProtocol
{
    let platform: Destination.Platform
    let id: String
    let name: String
    let os: Destination.OS

    init(destinationString: String) throws
    {
        throw HighwayError.implement("\(XCBuildDestinations.self) \(#function)")
    }
}
