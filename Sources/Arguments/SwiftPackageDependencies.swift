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

public protocol SwiftPackageDependenciesProtocol: AutoMockable
{
    // sourcery:inline:SwiftPackageDependencies.AutoGenerateProtocol
    var name: String { get }
    var path: String { get }
    var url: URL { get }
    var version: String { get }
    var dependencies: [SwiftPackageDependencies] { get }
    var description: String { get }

    func gitHooks() throws -> FolderProtocol
    func srcRoot() throws -> FolderProtocol
    func templateFolder() throws -> FolderProtocol
    func sourceryFolder() throws -> FolderProtocol
    func sourceryAutoProtocolFile() throws -> FileProtocol
    // sourcery:end
}

public struct SwiftPackageDependencies: Decodable, SwiftPackageDependenciesProtocol, CustomStringConvertible, AutoGenerateProtocol
{
    public let name: String
    public let path: String
    public let url: URL
    public let version: String

    public let dependencies: [SwiftPackageDependencies]

    public func gitHooks() throws -> FolderProtocol
    {
        return try srcRoot().subfolder(named: ".git/hooks")
    }

    public func srcRoot() throws -> FolderProtocol
    {
        return try Folder(path: url.absoluteString)
    }

    public func templateFolder() throws -> FolderProtocol
    {
        guard let templatePackage = (dependencies.first { $0.name == "template-sourcery" }) else
        {
            throw HighwayError.missingTemplateFolder("\(SwiftPackageDependencies.self) \(#function) \(#line):")
        }
        return try Folder(path: templatePackage.path)
    }

    public func sourceryFolder() throws -> FolderProtocol
    {
        guard let sourceryPackage = (dependencies.first { $0.name == "Sourcery" }) else
        {
            throw HighwayError.highwayError(atLocation: "\(SwiftPackageDependencies.self) \(#function) \(#line):", error: HighwayError.missingSourcery(""))
        }
        return try Folder(path: sourceryPackage.path)
    }

    public func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        return try templateFolder().subfolder(named: "Sources/SourceryAutoProtocols").file(named: "SourceryAutoProtocols.swift")
    }

    public var description: String
    {
        return """
        \(SwiftPackageDependencies.self)
        
        * name: \(name)
        * path: \(path)
        * url: \(url)
        
        # Dependencies
        
        \(dependencies.map { "  * \($0.name)" }.joined(separator: "\n"))
        
        """
    }
}
