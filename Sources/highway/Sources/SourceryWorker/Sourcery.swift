//
//  File.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Foundation
import os
import SignPost
import SourceryAutoProtocols
import Task
import Terminal
import ZFile

public protocol SourceryProtocol: ExecutableProtocol
{
    /// sourcery:inline:Sourcery.AutoGenerateProtocol
    var uuid: String { get }
    var name: String { get }
    var templateFolder: FolderProtocol { get }
    var outputFolder: FolderProtocol { get }
    var sourcesFolders: [FolderProtocol] { get }
    var individualSourceFiles: [File]? { get }
    var sourceryAutoProtocolsFile: FileProtocol { get }
    var sourceryYMLFile: FileProtocol { get }
    var sourceryExecutableFile: FileProtocol { get }
    var imports: Set<TemplatePrepend> { get }

    /// sourcery:end
}

public struct Sourcery: SourceryProtocol, AutoGenerateProtocol
{
    // MARK: - Identify the Sourcery Model

    public let uuid: String = UUID().uuidString
    public let name: String

    // MARK: - Folders and Files

    public let templateFolder: FolderProtocol
    public let outputFolder: FolderProtocol
    public let sourcesFolders: [FolderProtocol]
    public let individualSourceFiles: [File]?
    public let sourceryAutoProtocolsFile: FileProtocol
    public let sourceryYMLFile: FileProtocol
    public let sourceryExecutableFile: FileProtocol
    
    // MARK: - Imports to be prepended to templates

    public let imports: Set<TemplatePrepend>

    // MARK: - Private

    private let signPost: SignPostProtocol

    // MARK: - Init

    public init(
        sourcesFolders: [FolderProtocol],
        individualSourceFiles: [File]? = nil,
        templateFolder: FolderProtocol,
        outputFolder: FolderProtocol,
        sourceryAutoProtocolsFile: FileProtocol,
        sourceryYMLFile: FileProtocol,
        imports: Set<TemplatePrepend>,
        signPost: SignPostProtocol = SignPost.shared,
        sourceryExecutableFile: FileProtocol
    ) throws
    {
        self.templateFolder = templateFolder
        self.outputFolder = outputFolder
        self.sourcesFolders = sourcesFolders
        self.individualSourceFiles = individualSourceFiles
        self.sourceryAutoProtocolsFile = sourceryAutoProtocolsFile
        self.sourceryYMLFile = sourceryYMLFile
        self.imports = imports
        self.sourceryExecutableFile = sourceryExecutableFile
        // generate .sourcery file

        try sourceryYMLFile.write(
            string: """
            sources:
            \(sourcesFolders.map { "- \"\($0.path)\"" }.joined(separator: "\n"))
            - "\(sourceryAutoProtocolsFile.path)"
            \(individualSourceFiles == nil ? "" : individualSourceFiles!.map { "- \($0.path)" }.joined(separator: "\n"))
            templates:
            - "\(templateFolder.path)"
            output:
             "\(outputFolder.path)"
            """,
            encoding: .utf8
        )

        self.signPost = signPost
        signPost.verbose("🧙‍♂️ Sourcery YML file can be found at path:\n \(sourceryYMLFile.path)\n")

        name = sourcesFolders.map { $0.name }.joined(separator: "\n")
    }

    // sourcery:skipProtocol
    public func executableFile() throws -> FileProtocol
    {
        return sourceryExecutableFile
    }

    // MARK: - Error

    public struct ExecutableNotFoundError: Swift.Error, CustomDebugStringConvertible
    {
        let message: String
        let originalError: Error

        init(_ originalError: Error)
        {
            message = """
            
            🧙‍♂️ ExecutableNotFoundError
            
            You should install sourcery in your application folder by building it from source.
            Instructions on how to do that can be found https://github.com/krzysztofzablocki/Sourcery
            
            After that is done move the applition to the application folder so GitHooks can execute task
            
            `/Applications/Sourcery.app/Contents/MacOS/Sourcery`
            
            """
            self.originalError = originalError
        }

        public var debugDescription: String
        {
            return message
        }
    }
}
