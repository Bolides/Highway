//
//  File.swift
//  GitHooks
//
//  Created by Stijn on 07/07/2018.
//

import Arguments
import Errors
import Foundation
import os
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// sourcery:AutoMockable
public protocol SourceryProtocol
{
    // sourcery:inline:Sourcery.AutoGenerateProtocol
    var uuid: String { get }
    var name: String { get }
    var templateFolder: FolderProtocol { get }
    var outputFolder: FolderProtocol { get }
    var sourcesFolders: [FolderProtocol] { get }
    var individualSourceFiles: [File]? { get }
    var sourceryAutoProtocolsFile: FileProtocol { get }
    var sourceryYMLFile: FileProtocol { get }
    var sourceryBuilder: SourceryBuilderProtocol { get set }
    var imports: Set<TemplatePrepend> { get }

    init(
        productName: String,
        swiftPackageDependencies: DependencyProtocol,
        swiftPackageDump: DumpProtocol,
        sourceryBuilder: SourceryBuilderProtocol,
        signPost: SignPostProtocol
    ) throws
    mutating func executableFile() throws -> FileProtocol

    // sourcery:end
}

public struct Sourcery: SourceryProtocol, AutoGenerateProtocol
{
    // sourcery:skipProtocol
    static let commonImportAutoMockable: Set<TemplatePrepend.Import> = Set(
        [
            TemplatePrepend.Import(name: "SourceryAutoProtocols"),
            TemplatePrepend.Import(name: "Foundation"),
        ]
    )

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
    public var sourceryBuilder: SourceryBuilderProtocol

    // MARK: - Imports to be prepended to templates

    public let imports: Set<TemplatePrepend>

    // MARK: - Private

    private let signPost: SignPostProtocol

    // MARK: - Init

    // sourcery:includeInitInProtocol
    public init(
        productName: String,
        swiftPackageDependencies: DependencyProtocol,
        swiftPackageDump: DumpProtocol,
        sourceryBuilder: SourceryBuilderProtocol,
        signPost: SignPostProtocol = SignPost.shared
    ) throws
    {
        signPost.message("\(Sourcery.self) for \(productName)")

        do
        {
            let sourcesFolder = try swiftPackageDependencies.srcRoot().subfolder(named: "Sources")
            let productFolder = try sourcesFolder.subfolder(named: productName)
            let templateFolder = try sourceryBuilder.templateFolder()
            let outputFolder = try sourcesFolder
                .createSubfolderIfNeeded(withName: "Generated")
                .createSubfolderIfNeeded(withName: productName)

            let nameAutoMockable = "AutoMockable"
            var prepend = TemplatePrepend(name: Set([]), template: nameAutoMockable)

            if var imports = (swiftPackageDump.targets.first { $0.name == "\(productName)Mock" }?.dependencies.map { TemplatePrepend.Import(name: $0.name) })
            {
                imports.append(contentsOf: Sourcery.commonImportAutoMockable)
                imports.append(TemplatePrepend.Import(name: productName))

                prepend = TemplatePrepend(name: Set(imports), template: nameAutoMockable)
            }

            try self.init(
                sourcesFolders: [productFolder],
                templateFolder: templateFolder,
                outputFolder: outputFolder,
                sourceryAutoProtocolsFile: try sourceryBuilder.sourceryAutoProtocolFile(),
                sourceryYMLFile: try sourcesFolder.createFileIfNeeded(named: ".sourcery-\(productName).yml"),
                imports: Set([prepend]),
                sourceryBuilder: sourceryBuilder
            )
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(Sourcery.self) \(#function) \(#line) - \(productName) - depencies \(swiftPackageDependencies.name) at path \(try swiftPackageDependencies.srcRoot().name)", error: error)
        }
    }

    init(
        sourcesFolders: [FolderProtocol],
        individualSourceFiles: [File]? = nil,
        templateFolder: FolderProtocol,
        outputFolder: FolderProtocol,
        sourceryAutoProtocolsFile: FileProtocol,
        sourceryYMLFile: FileProtocol,
        imports: Set<TemplatePrepend>,
        signPost: SignPostProtocol = SignPost.shared,
        sourceryBuilder: SourceryBuilderProtocol
    ) throws
    {
        self.templateFolder = templateFolder
        self.outputFolder = outputFolder
        self.sourcesFolders = sourcesFolders
        self.individualSourceFiles = individualSourceFiles
        self.sourceryAutoProtocolsFile = sourceryAutoProtocolsFile
        self.sourceryYMLFile = sourceryYMLFile
        self.imports = imports
        self.sourceryBuilder = sourceryBuilder

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

    public mutating func executableFile() throws -> FileProtocol
    {
        return try sourceryBuilder.attemptToBuildSourceryIfNeeded()
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
