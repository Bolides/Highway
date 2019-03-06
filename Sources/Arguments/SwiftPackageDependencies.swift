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
public protocol SwiftPackageProtocol: AutoMockable {
    /// sourcery:inline:SwiftPackage.AutoGenerateProtocol
    var name: String { get }
    var url: URL { get }
    
    func srcRoot() throws -> FolderProtocol
    func templateFolder() throws -> FolderProtocol
    func sourceryFolder() throws -> FolderProtocol
    /// sourcery:end
}

public struct SwiftPackageDependencies: Decodable, SwiftPackageProtocol, CustomStringConvertible {
    
    public let name: String
    public let path: String
    public let url: URL

    public let dependencies: [SwiftPackageDependencies]
    
    public func srcRoot() throws -> FolderProtocol  {
        return try Folder(path: url.absoluteString)
    }
    
    public func templateFolder() throws -> FolderProtocol {
        
        guard let templatePackage = (dependencies.first { $0.name == "template-sourcery" }) else {
            throw  HighwayError.missingTemplateFolder("\(self) \(#function) \(#line):")
        }
        return try Folder(path: templatePackage.path)
    }
    
    public func sourceryFolder() throws -> FolderProtocol {
        
        guard let sourceryPackage = (dependencies.first { $0.name == "Sourcery" }) else {
            throw  HighwayError.missingTemplateFolder("\(self) \(#function) \(#line):")
        }
        return try Folder(path: sourceryPackage.path)
    }
    
    public var description: String {
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
