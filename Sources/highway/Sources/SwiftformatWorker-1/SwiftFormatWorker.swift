//
//  SwiftFormatWorker.swift
//  SwiftformatWorker
//
//  Created by Stijn on 03/01/2019.
//

import os
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

    private let folderToFormat: FolderProtocol
    private let configFile: FileProtocol
    private let queue: DispatchQueue
    private let signPost: SignPostProtocol

    public init(
        folderToFormat: FolderProtocol,
        configFile: FileProtocol,
        queue: DispatchQueue = DispatchQueue(label: "be.dooz.swiftFormat"),
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.folderToFormat = folderToFormat
        self.configFile = configFile
        self.queue = queue
        self.signPost = signPost
    }

    public func attempt(_ async: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    {
        queue.async
        { [weak self] in
            guard let `self` = self else { return }

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
