//
//  DemoSourceryWorker.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//  Copyright © 2018 dooz. All rights reserved.
//

import Foundation
import ProjectFolderWorker
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

public protocol AutomateHighwaySourceryWorkerProtocol: AutoMockable
{
    /// sourcery:inline:DemoSourceryWorker.AutoGenerateProtocol
    func attempt(_ async: (@escaping (@escaping SourceryWorker.SyncOutput) -> Void))
    /// sourcery:end
}

public class AutomateHighwaySourceryWorker: AutomateHighwaySourceryWorkerProtocol, AutoGenerateProtocol
{
    static let queue = DispatchQueue(label: "be.dooz.swiftformatWorker.sourceryWorker")

    private let signPost: SignPostProtocol
    private let workers: [SourceryWorkerProtocol]
    private static let commonImportAutoMockable = Set(
        [
            TemplatePrepend.Import(name: "SourceryAutoProtocols"),
            TemplatePrepend.Import(name: "Foundation"),
            TemplatePrepend.Import(name: "os"),
        ]
    )

    enum Target: String, CaseIterable
    {
        case Arguments
        case Deliver
        case Git
        case Keychain
        case SignPost
        case SourceryWorker
        case Terminal
        case Url
        case XCBuild
        case Errors
        case POSIX
        case Result
        case Task
        case SwiftformatWorker

        func imports() -> Set<TemplatePrepend>
        {
            // Insert the target itself
            var importNames = AutomateHighwaySourceryWorker.commonImportAutoMockable
            importNames.insert(TemplatePrepend.Import(name: rawValue))
            importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFile.rawValue))
            importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFileMock.rawValue))

            // If not the default, add a case and insert imports into importNames
            switch self {
            case .Task:
                importNames.insert(TemplatePrepend.Import(name: Target.Arguments.rawValue))
                importNames.insert(TemplatePrepend.Import(name: Target.SignPost.rawValue))

                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            case .Terminal:
                importNames.insert(TemplatePrepend.Import(name: Target.Arguments.rawValue))

                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            default:
                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            }
        }
    }

    enum VendorFramework: String, CaseIterable
    {
        case ZFile
        case ZFileMock
    }

    enum Template: String
    {
        case AutoMockable
    }

    init(
        signPost: SignPostProtocol = SignPost.shared,
        projectFolderWorkerType: ProjectFolderWorkerProtocol.Type = ProjectFolderWorker.self,
        workers: [SourceryWorkerProtocol]? = nil
    ) throws
    {
        self.signPost = signPost

        guard workers == nil else
        {
            self.workers = workers!
            return
        }

        var currentFolder: FolderProtocol = FileSystem().currentFolder
        var projectFolder = currentFolder
        var sourcesFolder = currentFolder
        var carthageFolder: FolderProtocol!

        do
        {
            signPost.message("💁🏻‍♂️ Running in current folder\n\(currentFolder)\n, If this is not the correct folder run AutomateZFile from the folder you want.\n AutomateZFile cannot work for derived data folder.")

            sourcesFolder = try projectFolder.subfolder(named: "Sources")
            carthageFolder = try projectFolder.parentFolder().subfolder(named: "Carthage")
        }
        catch
        {
            signPost.message("⚠️ Failed to runn from current folder at\(currentFolder.path) ⚠️")
            signPost.message("💁🏻‍♂️ Will try to run from folder defined in Info.plist with key \(ProjectFolderWorker.Key.scrRoot.rawValue) ...")

            currentFolder = try projectFolderWorkerType.init(bundle: Bundle.main).srcRoot.folder
            projectFolder = currentFolder

            sourcesFolder = try projectFolder.subfolder(named: "Sources")
            carthageFolder = try projectFolder.parentFolder().subfolder(named: "Carthage")
        }

        signPost.verbose("💁🏻‍♂️ Project in folder\n \(projectFolder.path)\n")
        signPost.verbose("💁🏻‍♂️ Sources in folder\n \(sourcesFolder.path)\n")
        signPost.verbose("💁🏻‍♂️ Carthage in folder\n \(sourcesFolder.path)\n")

        let highwayFolder = projectFolder
        let templateFolder = try Folder(relativePath: "Checkouts/template-sourcery/Sources/stencil", to: carthageFolder)
        let sourceryAutoProtocolFile = try highwayFolder.file(named: "/Sources/SourceryAutoProtocols/SourceryAutoProtocols.swift")
        let autoGeneratedCodeFolder = try projectFolder.createSubfolderIfNeeded(withName: "/Sources/AutoGeneratedCode")

        let sourcerySequence = try Target.allCases.map
        { target in
            return try Sourcery(
                sourcesFolders: [sourcesFolder.subfolder(named: target.rawValue)],
                individualSourceFiles: nil,
                templateFolder: templateFolder,
                outputFolder: try autoGeneratedCodeFolder.createSubfolderIfNeeded(withName: target.rawValue),
                sourceryAutoProtocolsFile: sourceryAutoProtocolFile,
                sourceryYMLFile: try projectFolder.createFileIfNeeded(named: ".sourcery-\(target.rawValue).yml"),
                imports: target.imports()
            )
        }

        signPost.verbose("🧙‍♂️ Sourcery will run from config files ...")
        try sourcerySequence.forEach
        {
            signPost.verbose(
                """
                > \($0.sourceryYMLFile.path)
                
                ```yml
                \(try $0.sourceryYMLFile.readAsString())
                ```
                
                """
            )
        }

        let swiftFormatWorker = try SwiftFormatWorker(forAutogeneratedCode: ProjectFolderWorker.self, queue: AutomateHighwaySourceryWorker.queue)

        self.workers = sourcerySequence.map { SourceryWorker(sourcery: $0, swiftFormatWorker: swiftFormatWorker, queue: AutomateHighwaySourceryWorker.queue) }
    }

    // MARK: - Error

    enum Error: Swift.Error, CustomStringConvertible
    {
        var description: String { return "⚠️ You are running in derived data folder. See README of project on github doozMen/highway to change your project settings!" }

        case runningInDerivedDataFolder
    }

    // MARK: - Sourcery Setup

    public func attempt(_ async: (@escaping (@escaping SourceryWorker.SyncOutput) -> Void))
    {
        workers.forEach
        { [weak self] in

            guard let `self` = self else { return }

            $0.attempt
            { syncOutput in
                async
                {
                    let output = try syncOutput()
                    self.signPost.verbose("\(output.joined(separator: "\n"))")
                    return output
                }
            }
        }
    }
}
