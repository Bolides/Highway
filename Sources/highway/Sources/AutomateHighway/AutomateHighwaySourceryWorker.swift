//
//  DemoSourceryWorker.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//  Copyright © 2018 dooz. All rights reserved.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

public protocol AutomateHighwaySourceryWorkerProtocol: AutoMockable
{
    /// sourcery:inline:DemoSourceryWorker.AutoGenerateProtocol
    func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    /// sourcery:end
}

public class AutomateHighwaySourceryWorker: AutomateHighwaySourceryWorkerProtocol, AutoGenerateProtocol
{
    public static let queue = DispatchQueue(label: "be.dooz.swiftformatWorker.sourceryWorker")

    // MARK: - Private

    private static let commonImportAutoMockable = Set(
        [
            TemplatePrepend.Import(name: "SourceryAutoProtocols"),
            TemplatePrepend.Import(name: "Foundation"),
            TemplatePrepend.Import(name: "os"),
        ]
    )

    private let signPost: SignPostProtocol
    private var workers: [SourceryWorkerProtocol]

    private let queue: DispatchQueue

    private let disk: DiskProtocol

    private let highwayFolder: FolderProtocol
    private let sourcesFolder: FolderProtocol
    private let templateFolder: FolderProtocol
    private let autoGeneratedCodeFolder: FolderProtocol

    private let sourceryAutoProtocolFile: FileProtocol

    // MARK: - Init

    init(
        disk: DiskProtocol,
        signPost: SignPostProtocol = SignPost.shared,
        queue: DispatchQueue = AutomateHighwaySourceryWorker.queue
    ) throws
    {
        self.signPost = signPost
        self.queue = queue
        self.disk = disk

        highwayFolder = try disk.srcRoot.subfolder(named: "Sources/highway")
        sourcesFolder = try highwayFolder.subfolder(named: "Sources")

        templateFolder = try disk.carthage.checkouts.subfolder(named: "template-sourcery/Sources/stencil")
        sourceryAutoProtocolFile = try highwayFolder.subfolder(named: "Sources/SourceryAutoProtocols").file(named: "SourceryAutoProtocols.swift")
        autoGeneratedCodeFolder = try highwayFolder.createSubfolderIfNeeded(withName: "/Sources/AutoGeneratedCode")
        workers = [SourceryWorkerProtocol]()
    }

    // MARK: - Error

    // MARK: - Sourcery Setup

    public func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        queue.async
        { [weak self] in
            guard let `self` = self else
            {
                async { throw "\(AutomateHighwaySourceryWorker.self) \(#function) could not complete because self was released" }
                return
            }
            do
            {
                let sourceryExecutableFile = try SourceryBuilder().attemptToBuildSourceryIfNeeded()

                let sourcerySequence = try Target.allCases.map
                { target in
                    try Sourcery(
                        sourcesFolders: [self.sourcesFolder.subfolder(named: target.rawValue)],
                        individualSourceFiles: nil,
                        templateFolder: self.templateFolder,
                        outputFolder: try self.autoGeneratedCodeFolder.createSubfolderIfNeeded(withName: target.rawValue),
                        sourceryAutoProtocolsFile: self.sourceryAutoProtocolFile,
                        sourceryYMLFile: try self.highwayFolder.createFileIfNeeded(named: ".sourcery-\(target.rawValue).yml"),
                        imports: target.imports(),
                        sourceryExecutableFile: sourceryExecutableFile
                    )
                }

                self.signPost.verbose("🧙‍♂️ Sourcery will run from config files ...")

                try sourcerySequence.forEach
                {
                    self.signPost.verbose(
                        """
                        > \($0.sourceryYMLFile.path)
                        
                        ```yml
                        \(try $0.sourceryYMLFile.readAsString())
                        ```
                        
                        """
                    )
                }

                self.workers = try sourcerySequence.map
                {
                    try SourceryWorker(sourcery: $0, queue: AutomateHighwaySourceryWorker.queue)
                }
            }
            catch
            {
                async { throw error }
                return
            }

            self.workers.forEach
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

    // MARK: - Enum

    enum Target: String, CaseIterable
    {
        case Arguments
        case Git
        case Keychain
        case SignPost
        case SourceryWorker
        case Terminal
        case Url
        case XCBuild
        case Errors
        case POSIX
        case Task
        case SwiftFormatWorker

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
}
