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
    var dependencies: [SubDependency] { get }

    func folderType() -> FolderProtocol.Type
    // sourcery:end

    func gitHooks() throws -> FolderProtocol
    func srcRoot() throws -> FolderProtocol
    func templateFolder() throws -> FolderProtocol
    func sourceryFolder() throws -> FolderProtocol
    func sourceryAutoProtocolFile() throws -> FileProtocol
}

public struct SubDependency: Decodable, DependencyProtocol
{
    public let name: String
    public let path: String
    public let url: URL
    public let version: String

    public let dependencies: [SubDependency]
}

public struct Dependency<F: FolderProtocol>: Decodable, DependencyProtocol, CustomStringConvertible, AutoGenerateProtocol
{
    public let name: String
    public let path: String
    public let url: URL
    public let version: String

    public let dependencies: [SubDependency]

    public func folderType() -> FolderProtocol.Type
    {
        return F.self
    }
}

extension DependencyProtocol
{
    public func folderType() -> FolderProtocol.Type
    {
        return Folder.self
    }

    public func gitHooks() throws -> FolderProtocol
    {
        return try srcRoot().subfolder(named: ".git/hooks")
    }

    public func srcRoot() throws -> FolderProtocol
    {
        return try folderType().init(path: url.absoluteString)
    }

    public func templateFolder() throws -> FolderProtocol
    {
        let expectedName = "template-sourcery"

        guard let templatePackage = (dependencies.first { $0.name == expectedName }) else
        {
            guard name == expectedName else
            {
                throw HighwayError.missingTemplateFolder("\(Dependency<Folder>.self) \(#function) \(#line):")
            }
            return try srcRoot().subfolder(named: "Sources/stencil")
        }
        return try folderType().init(path: templatePackage.path)
    }

    public func sourceryFolder() throws -> FolderProtocol
    {
        guard let sourceryPackage = (dependencies.first { $0.name == "Sourcery" }) else
        {
            throw HighwayError.highwayError(atLocation: "\(Dependency<Folder>.self) \(#function) \(#line):", error: HighwayError.missingSourcery(""))
        }
        return try folderType().init(path: sourceryPackage.path)
    }

    public func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        return try templateFolder().subfolder(named: "Sources/SourceryAutoProtocols").file(named: "SourceryAutoProtocols.swift")
    }

    public var description: String
    {
        let dependenciesString: String = dependencies.map { "  * \($0.name)" }.joined(separator: "\n")

        return """
        \(Dependency<Folder>.self)
        
        * name: \(name)
        * path: \(path)
        * url: \(url)
        
        # Dependencies
        
        \(dependenciesString)
        
        """
    }
}
