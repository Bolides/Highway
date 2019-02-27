//
//  SwiftFormatWorker.swift
//  SwiftFormatWorker
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
    /// sourcery:inline:SwiftFormatWorker.AutoGenerateProtocol

    func attempt(_ async: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    /// sourcery:end
}

public class SwiftFormatWorker: SwiftFormatWorkerProtocol, AutoGenerateProtocol
{
    public static let queue: DispatchQueue = DispatchQueue(label: "be.dooz.swiftFormat")
    
    public typealias SyncOutput = () throws -> Void

    public let queue: DispatchQueue

    // MARK: - Private

    private let configFile: FileProtocol
    private let signPost: SignPostProtocol
    private let folderToFormatRecursive: FolderProtocol
    
    // MARK: - Init

    public init(
        folderToFormatRecursive: FolderProtocol = FileSystem.shared.currentFolder,
        configFile: FileProtocol,
        queue: DispatchQueue = SwiftFormatWorker.queue,
        signPost: SignPostProtocol = SignPost.shared
    ) throws
    {
        self.queue = queue
        self.signPost = signPost
        self.configFile = configFile
        self.folderToFormatRecursive = folderToFormatRecursive
    }

    public convenience init() throws {
        guard let configPath = Bundle.main.path(forResource: ".swiftformat", ofType: "md") else {
            throw Error.swiftFormatCannotRunWithoutConfigFileInBundle
        }
        
        let configFile = try File(path: configPath)
        
        try self.init(configFile: configFile)
    }

    public func attempt(_ asyncSwiftFormatAttemptOutput: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    {
        queue.async
        { [weak self] in
            guard let `self` = self else { return }
           
            let formatSettings = try? self.configFile.readAsString()
            self.signPost.verbose("👨🏻‍🏫  SwiftFormat \(self.folderToFormatRecursive.name) \n with settings \n \(String(describing: formatSettings))\n ...\n")

            CLI.print = { message, type in
                switch type {
                case .info, .success, .content:
                    self.signPost.message("👨🏻‍🏫 SwiftFormat \(self.folderToFormatRecursive.name) \n\(message)\n ❌")
                case .error:
                    asyncSwiftFormatAttemptOutput { throw Error.cliError("🌋 \n\(message)\n") }
                    break
                case .warning:
                    self.signPost.message("⚠️ \n\(message)\n")
                }
            }

            let arguments = ["", self.folderToFormatRecursive.path, "--config", self.configFile.path]
            let output = CLI.run(in: self.folderToFormatRecursive.path, with: arguments)

            switch output {
            case .ok:
                asyncSwiftFormatAttemptOutput { return }
            case .lintFailure, .error:
                asyncSwiftFormatAttemptOutput { throw Error.cliError("\(output)") }
                break
            }
        }
    }

    // MARK: - Error

    enum Error: Swift.Error, Equatable
    {
        case cliError(String)
        case swiftFormatCannotRunWithoutConfigFileInBundle
        
    }
}
