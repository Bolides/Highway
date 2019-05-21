import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol SecretsWorkerProtocol: AutoMockable
{
    // sourcery:inline:SecretsWorker.AutoGenerateProtocol
    static var shared: SecretsWorker { get }

    func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol

    // sourcery:end
}

public struct SecretsWorker: SecretsWorkerProtocol, AutoGenerateProtocol
{
    public static let shared = SecretsWorker()

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol

    // MARK: - init

    public init(
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.terminal = terminal
        self.system = system
        self.signPost = signPost
    }

    // This relies on brew install git-secret
    public func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    {
        signPost.message("\(pretty_function()) ...")

        do
        {
            let git = try gitSecretProcess(in: folder)
            git.arguments = ["hide"]

            let output = try terminal.runProcess(git)
            signPost.message("\(pretty_function()) ✅")
            return output
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    {
        signPost.message("\(pretty_function()) ...")

        do
        {
            let srcRoot: FolderProtocol = folder

            // Delete all .gpg files

            try folder.makeFileSequence().forEach
            { file in
                if file.name.hasSuffix(".gpg")
                {
                    try file.delete()
                }
            }

            // gpg --symetric all git secrets

            let git = try gitSecretProcess(in: srcRoot)
            git.arguments = ["list"]

            var gitSecretListOutput = try terminal.runProcess(git)
            gitSecretListOutput = (gitSecretListOutput.filter { $0.count > 0 })

            guard gitSecretListOutput.count > 0 else
            {
                return []
            }

            let files = try gitSecretListOutput.map { try srcRoot.file(named: $0) }

            for file in files
            {
                let gpg = try system.processFromBrew(formula: "gpg", in: srcRoot)
                gpg.arguments = ["-c", file.name]

                let output = try terminal.runProcess(gpg)
                signPost.verbose(output.joined(separator: "\n"))
            }

            signPost.message("\(pretty_function()) ✅")
            return files.map { $0.path }
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        return try system.processFromBrew(formula: "git-secret", in: folder)
    }
}
