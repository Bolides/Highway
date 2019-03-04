//
//  MinimalTestOptions.swift
//  XCBuild
//
//  Created by Stijn on 26/02/2019.
//

import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// sourcery:AutoMockable
public protocol MinimalTestOptionsProtocol
{
    /// sourcery:inline:MinimalTestOptions.AutoGenerateProtocol

    func arguments() throws -> Arguments
    /// sourcery:end
}

public struct MinimalTestOptions: MinimalTestOptionsProtocol, AutoGenerateProtocol, CustomStringConvertible
{
    private let scheme: String
    private let workspace: FolderProtocol
    private let destination: Destination?
    private let xcodebuild: XCBuildProtocol
    private let signPost: SignPostProtocol

    // xcodebuild test -workspace ios/ReactNativeConfig.xcworkspace -scheme RNConfiguration-macOS
    // You can create a destination with the destination factory
    public init(
        scheme: String,
        workspace: FolderProtocol,
        xcodebuild: XCBuildProtocol,
        destination: Destination? = nil,
        signPost: SignPostProtocol = SignPost.shared

    ) throws
    {
        self.scheme = scheme
        self.workspace = workspace
        self.destination = destination
        self.xcodebuild = xcodebuild
        self.signPost = signPost
    }

    public func arguments() throws -> Arguments
    {
        var args = Arguments([])

        args += _option("scheme", value: scheme)
        args += _option("workspace", value: workspace.path)

        if destination != nil
        {
            let destinations = try xcodebuild.findPosibleDestinations(for: scheme, in: workspace)
            signPost.verbose("possibleDestinations \(destinations) \n choosing first\n")

            if let firstDestination = destinations.first
            {
                args += _option("destination", value: firstDestination)
            }
        }

        args.append(["-quiet", "test"]) // arguments without a value

        return args
    }
    
    // MARK: - CustomStringConvertible
    
    public var description: String {
        
        return """
        
        \(MinimalTestOptions.self)
        
        * scheme: \(scheme)
        * workSpace: \(workspace.name)
        * optional destination: \(String(describing: destination))
        
        """
    }
    

}
