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
public protocol MinimalTestOptionsProtocol: ArgumentExecutableProtocol
{
    /// sourcery:inline:MinimalTestOptions.AutoGenerateProtocol

    func arguments() throws -> Arguments
    func executableFile() throws -> FileProtocol
    /// sourcery:end
}

public struct MinimalTestOptions: MinimalTestOptionsProtocol, AutoGenerateProtocol
{
    private let scheme: String
    private let workspace: FolderProtocol
    private let destination: Destination?
    private let xcodebuild: XCBuildProtocol

    // xcodebuild test -workspace ios/ReactNativeConfig.xcworkspace -scheme RNConfiguration-macOS
    // You can create a destionation with the destination factory
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
    }

    public func arguments() throws -> Arguments
    {
        var args = Arguments([])

        args += _option("scheme", value: scheme)
        args += _option("workspace", value: workspace.path)

        // TODO: run xcodebuild -showdestinations -scheme RNConfigurationBridge-iOS -workspace ReactNativeConfig.xcworkspace for possible destionations
        // TODO: pick one
        // return

        if let destination = destination
        {
            let destinations = try xcodebuild.findPosibleDestinations(for: scheme, in: workspace)

//            args += _option("destination", value: destination)
        }

        args.append(["-quiet", "test"]) // arguments without a value

        return args
    }

    enum Error: Swift.Error
    {
        case implement
    }

    public func executableFile() throws -> FileProtocol
    {
        throw Error.implement
    }
}
