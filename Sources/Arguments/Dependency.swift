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

public protocol DependencyProtocol: AutoMockable
{
    // sourcery:inline:Dependency.AutoGenerateProtocol
    var name: String { get }
    var path: String { get }
    var url: URL { get }
    var version: String { get }
    var dependencies: [Dependency] { get }
    var description: String { get }

    func gitHooks() throws  -> FolderProtocol
    func srcRoot() throws  -> FolderProtocol
    func templateFolder() throws  -> FolderProtocol
    func templateFolder(expectedName: String) throws  -> FolderProtocol
    func sourceryFolder() throws  -> FolderProtocol
    func sourceryAutoProtocolFile() throws  -> FileProtocol
    // sourcery:end
}

public struct Dependency: Decodable, DependencyProtocol, CustomStringConvertible, AutoGenerateProtocol
{
    public let name: String
    public let path: String
    public let url: URL
    public let version: String

    public let dependencies: [Dependency]

    public init(
        name: String,
        path: String,
        url: URL,
        version: String,
        dependencies: [Dependency]
    )
    {
        self.name = name
        self.path = path
        self.url = url
        self.version = version
        self.dependencies = dependencies
    }

    public var description: String
    {
        return """
        \(Dependency.self)
        
        * name: \(name)
        * path: \(path)
        * url: \(url)
        
        # Dependencies
        
        \(dependencies.map { "  * \($0.name)" }.joined(separator: "\n"))
        
        """
    }

    // MARK: - Public Functions

    public func gitHooks() throws -> FolderProtocol
    {
        return try srcRoot().subfolder(named: ".git/hooks")
    }

    public func srcRoot() throws -> FolderProtocol
    {
        return try Folder(path: path)
    }

    /// Will look for package named "template-sourcery"
    public func templateFolder() throws -> FolderProtocol
    {
        return try templateFolder(expectedName: "template-sourcery")
    }

    public func templateFolder(expectedName: String) throws -> FolderProtocol
    {
        guard let templatePackage = (dependencies.first { $0.name == expectedName }) else
        {
            throw HighwayError.missingTemplateFolder("\(Dependency.self) \(#function) \(#line):")
        }
        return try Folder(path: templatePackage.path)
    }

    public func sourceryFolder() throws -> FolderProtocol
    {
        guard let sourceryPackage = (dependencies.first { $0.name == "Sourcery" }) else
        {
            throw HighwayError.highwayError(atLocation: "\(Dependency.self) \(#function) \(#line):", error: HighwayError.missingSourcery(""))
        }
        return try Folder(path: sourceryPackage.path)
    }

    public func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        return try templateFolder().subfolder(named: "Sources/SourceryAutoProtocols").file(named: "SourceryAutoProtocols.swift")
    }
}
