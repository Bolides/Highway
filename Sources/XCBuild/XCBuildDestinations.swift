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
    // highway:inline:XCBuildDestinations.AutoGenerateProtocol
    var platform: Destination.Platform { get }
    var id: String { get }
    var name: String { get }
    var os: Destination.OS { get }
    // highway:end
}

public struct XCBuildDestinations: XCBuildDestinationsProtocol, AutoGenerateProtocol
{
    public let platform: Destination.Platform
    public let id: String
    public let name: String
    public let os: Destination.OS

    init(destinationString: String) throws
    {
        throw HighwayError.implement("\(XCBuildDestinations.self) \(#function)")
    }
}
