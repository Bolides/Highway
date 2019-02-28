//
//  MinimalTestOptions.swift
//  XCBuild
//
//  Created by Stijn on 26/02/2019.
//

import Arguments
import Foundation
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

    // xcodebuild test -workspace ios/ReactNativeConfig.xcworkspace -scheme ReactNativeConfigSwift-macOS
    public init(
        scheme: String,
        workspace: FolderProtocol
    ) throws
    {
        self.scheme = scheme
        self.workspace = workspace
    }

    public func arguments() throws -> Arguments
    {
        var args = Arguments([])

        args += _option("scheme", value: scheme)
        args += _option("workspace", value: workspace.path)

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
