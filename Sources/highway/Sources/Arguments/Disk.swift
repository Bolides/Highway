//
//  Disk.swift
//  Arguments
//
//  Created by Stijn on 28/02/2019.
//

import Foundation

import Errors
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol DiskProtocol: AutoMockable
{
    /// sourcery:inline:Disk.AutoGenerateProtocol
    var srcRoot: FolderProtocol { get }
    var carthage: Disk.Carthage { get }
    /// sourcery:end
}

/// Will deliver files based on the arguments passed from the commandline
public struct Disk: DiskProtocol, AutoGenerateProtocol
{
    /// Root folder where project and its dependencies are is located
    public let srcRoot: FolderProtocol
    public let carthage: Disk.Carthage

    public struct Carthage
    {
        public enum Path: String, CaseIterable
        {
            case checkouts = "Carthage/Checkouts"
            case sourcery = "Sourcery"
        }

        public let checkouts: FolderProtocol
        public let sourcery: FolderProtocol
    }

    private let signPost: SignPostProtocol

    public init(
        highwayCommandLineArguments: HighwayCommandLineOption.Values = HighwayCommandLineOption.Values(),
        signPost: SignPostProtocol = SignPost.shared
    ) throws
    {
        do {
            guard let relativeProjectPath = (highwayCommandLineArguments.ordered.compactMap { $0.srcRoot }.first) else
            {
                throw HighwayError.missingSrcroot(
                    message: """
                    You can provide the following options
                    \(HighwayCommandLineOption.allCases.map { $0.rawValue }.joined(separator: "\n"))
                    """,
                    function: "\(#function)"
                )
            }
            
            srcRoot = try Folder(relativePath: relativeProjectPath)
            self.signPost = signPost
            
            signPost.verbose("Looking for \(Carthage.Path.checkouts.rawValue) \nfrom\n \(srcRoot)\n")
            let carthageCheckouts = try srcRoot.subfolder(named: Carthage.Path.checkouts.rawValue)
            
            signPost.verbose("Looking for \(Carthage.Path.sourcery.rawValue)")
            
            carthage = Carthage(
                checkouts: carthageCheckouts,
                sourcery: try carthageCheckouts.subfolder(named: Carthage.Path.sourcery.rawValue)
            )
        } catch {
            throw "\(Disk.self) \(#function)\n\(error)"
        }
        
    }
}
