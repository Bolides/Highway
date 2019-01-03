//
//  SwiftFormatWorker.swift
//  SwiftformatWorker
//
//  Created by Stijn on 03/01/2019.
//

import os
import ProjectFolderWorker
import SignPost
import SourceryAutoProtocols
import SwiftFormat
import ZFile

public protocol SwiftFormatWorkerProtocol: AutoMockable
{
    /// sourcery:inline:SwiftformatWorker.AutoGenerateProtocol

    func attempt(_ async: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    /// sourcery:end
}

public class SwiftFormatWorker: SwiftFormatWorkerProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> Void

    public let queue: DispatchQueue

    // MARK: - Private

    private let folderToFormat: FolderProtocol
    private let configFile: FileProtocol
    private let signPost: SignPostProtocol

    // MARK: - Init

    public init(
        forAutogeneratedCode
        projectFolderWorkerType: ProjectFolderWorkerProtocol.Type,
        queue: DispatchQueue = DispatchQueue(label: "be.dooz.swiftFormat"),
        signPost: SignPostProtocol = SignPost.shared
    ) throws
    {
        self.queue = queue
        self.signPost = signPost

        var folderToFormat: FolderProtocol!
        var currentFolder: FolderProtocol = FileSystem.shared.currentFolder

        signPost.message("💁🏻‍♂️ swiftformate init ...")

        signPost.message("💁🏻‍♂️ Running in current folder\n\(currentFolder)\n, If this is not the correct folder run AutomateZFile from the folder you want.\n AutomateZFile cannot work for derived data folder.")
        do
        {
            folderToFormat = try currentFolder.subfolder(named: "Sources/AutoGeneratedCode")
        }
        catch
        {
            signPost.message("⚠️ Failed to run from current folder at\(FileSystem.shared.currentFolder.path) ⚠️")
            signPost.message("💁🏻‍♂️ Will try to run from folder defined in Info.plist with key \(ProjectFolderWorker.Key.scrRoot.rawValue) ...")

            currentFolder = try projectFolderWorkerType.init(bundle: Bundle.main).srcRoot.folder
            folderToFormat = try currentFolder.subfolder(named: "Sources/AutoGeneratedCode")
        }

        configFile = try folderToFormat.file(named: ".swiftformat.md")
        self.folderToFormat = folderToFormat
    }

    public init(
        forSources
        projectFolderWorkerType: ProjectFolderWorkerProtocol.Type,
        queue: DispatchQueue = DispatchQueue(label: "be.dooz.swiftFormat"),
        signPost: SignPostProtocol = SignPost.shared
    ) throws
    {
        self.queue = queue
        self.signPost = signPost

        var folderToFormat: FolderProtocol!
        var currentFolder: FolderProtocol = FileSystem.shared.currentFolder

        signPost.message("💁🏻‍♂️ swiftformate init ...")

        signPost.message("💁🏻‍♂️ Running in current folder\n\(currentFolder)\n, If this is not the correct folder run AutomateZFile from the folder you want.\n AutomateZFile cannot work for derived data folder.")
        do
        {
            folderToFormat = try currentFolder.subfolder(named: "Sources")
        }
        catch
        {
            signPost.message("⚠️ Failed to run from current folder at\(FileSystem.shared.currentFolder.path) ⚠️")
            signPost.message("💁🏻‍♂️ Will try to run from folder defined in Info.plist with key \(ProjectFolderWorker.Key.scrRoot.rawValue) ...")

            currentFolder = try projectFolderWorkerType.init(bundle: Bundle.main).srcRoot.folder
            folderToFormat = try currentFolder.subfolder(named: "Sources")
        }

        configFile = try currentFolder.file(named: ".swiftformat.md")
        self.folderToFormat = folderToFormat
    }

    public func attempt(_ async: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    {
        queue.async
        { [weak self] in
            guard let `self` = self else { return }

            self.signPost.message("💁🏻‍♂️ swiftformat started ...")

            CLI.print = { message, type in
                switch type {
                case .info, .success, .content:
                    self.signPost.message("💁🏻‍♂️ \n\(message)\n")
                case .error:
                    async { throw Error.cliError("🌋 \n\(message)\n") }
                case .warning:
                    self.signPost.message("⚠️ \n\(message)\n")
                }
            }

            let arguments = ["", self.folderToFormat.path, "--config", self.configFile.path]
            let output = CLI.run(in: self.folderToFormat.path, with: arguments)

            switch output {
            case .ok:
                async {}
            case .lintFailure, .error:
                async { throw Error.cliError("\(output)") }
            }
        }
    }

    // MARK: - Error

    enum Error: Swift.Error, Equatable
    {
        case cliError(String)
    }
}
