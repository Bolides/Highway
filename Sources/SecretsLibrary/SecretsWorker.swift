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
    static var gitSecretname: String { get set }

    func revealSecrets(in folder: FolderProtocol) throws -> [String]
    func secretsChangedSinceLastPush(in folder: FolderProtocol) throws -> [String]
    func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    func commitHiddenSecrets(in folder: FolderProtocol) throws -> [String]
    func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol

    // sourcery:end
}

public struct SecretsWorker: SecretsWorkerProtocol, AutoGenerateProtocol
{
    public static let shared = SecretsWorker()
    public static var gitSecretname = "git-secret"

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol
    private let fileSystem: FileSystemProtocol

    // MARK: - init

    public init(
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared,
        signPost: SignPostProtocol = SignPost.shared,
        fileSystem: FileSystemProtocol = FileSystem.shared
    )
    {
        self.terminal = terminal
        self.system = system
        self.signPost = signPost
        self.fileSystem = fileSystem
    }

    // MARK: - Secret reveal

    /**
     reveals secrets if they are not already revealed
     */
    public func revealSecrets(in folder: FolderProtocol) throws -> [String]
    {
        do
        {
            let list = try system.installOrGetProcessFromBrew(formula: SecretsWorker.gitSecretname, in: folder)
            list.arguments = ["list"]
            let listOutput = try terminal.runProcess(list).filter { !$0.isEmpty }
            var message = "revealing secrets \(listOutput.joined(separator: "\n")) ✅"
            do
            {
                try listOutput.forEach
                { file in
                    guard folder.containsFile(named: file) else
                    {
                        throw "reveal secrets"
                    }
                }

                message = "no need to reveal secrets"
            }
            catch
            {
                signPost.message("revealing secrets \(listOutput.joined(separator: "\n")) ...")
                let reveal = try system.installOrGetProcessFromBrew(formula: SecretsWorker.gitSecretname, in: folder)
                reveal.arguments = ["reveal"]
                try terminal.runProcess(reveal)
            }

            return [message]
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Secret changes

    /**
     Returns with true if the secrets listed by git secret have changed
     It stores a file with json named SecretsWorker.secretFileDateChangePath in the root folder
     later it checks for dates with keys of the relative paths to the secrets files and returns with false if files have changed.

     - parameters:
     - folder : FolderProtocol = root git folder containing .secrets
     - returns: list of changed files paths relative to folder
     */
    public func secretsChangedSinceLastPush(in folder: FolderProtocol) throws -> [String]
    {
        do
        {
            let gitSecretList = try gitSecretProcess(in: folder)
            gitSecretList.arguments = ["list"]

            let listOutput = try terminal.runProcess(gitSecretList).filter { !$0.isEmpty }

            var changedPaths = [String]()

            try listOutput.forEach
            { secretFilePath in
                let gitSecretChanged = try gitSecretProcess(in: folder)
                gitSecretChanged.arguments = ["changes", secretFilePath]

                let output = try terminal.runProcess(gitSecretChanged).filter { !$0.isEmpty }

                if output.count > 1
                {
                    changedPaths.append(secretFilePath)
                }
            }

            return changedPaths
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - git-secret

    /**
     Will throw to make you run secrets to hide secrets with git-secret ang gpg
     */
    public func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    {
        guard try secretsChangedSinceLastPush(in: folder).count > 0 else
        {
            return ["\(pretty_function()) no secret changes, skipping"]
        }

        signPost.message("\(pretty_function()) ...")

        do
        {
            let git = try gitSecretProcess(in: folder)
            git.arguments = ["hide"]

            let output = try terminal.runProcess(git)
            signPost.verbose("\(output.joined(separator: "\n"))")
            try commitHiddenSecrets(in: folder)
            signPost.message("\(pretty_function()) ✅")
            return output
        }
        catch
        {
            signPost.error("\(pretty_function()) \n\(error)\n❌")

            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Commit secret files

    @discardableResult
    public func commitHiddenSecrets(in folder: FolderProtocol) throws -> [String]
    {
        signPost.message("\(pretty_function()) ...")

        do
        {
            let gitAdd = try system.process("git")
            gitAdd.currentDirectoryPath = folder.path
            gitAdd.arguments = ["add"]

            let gitSecretList = try gitSecretProcess(in: folder)
            gitSecretList.arguments = ["list"]

            let gitSecretListPaths = try terminal.runProcess(gitSecretList).filter { $0.count > 0 }

            var list = gitSecretListPaths.map { $0 + ".gpg" }

            list.append(contentsOf: gitSecretListPaths.map { $0 + ".secret" })

            gitAdd.arguments?.append(contentsOf: list)

            try terminal.runProcess(gitAdd)

            let gitCommit = try system.process("git")
            gitCommit.currentDirectoryPath = folder.path
            gitCommit.arguments = ["commit", "-m", "\(pretty_function()) added and committed secrets \(list.joined(separator: ","))"]

            let output = try terminal.runProcess(gitCommit)

            signPost.message("\(pretty_function()) ✅")

            return output
        }
        catch
        {
            signPost.message("\(pretty_function()) ❌")

            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - gpg secrets

    public func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    {
        signPost.message("\(pretty_function()) ...")

        let secretFilePaths = try secretsChangedSinceLastPush(in: folder)

        guard secretFilePaths.count > 0 else
        {
            return ["\(pretty_function()) no secrets changed, skipping! ✅"]
        }

        signPost.message("secret files changed \n \(secretFilePaths.joined(separator: "\n"))")

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

            let gitSecrets = try gitSecretProcess(in: srcRoot)
            gitSecrets.arguments = ["list"]

            var gitSecretListOutput = try terminal.runProcess(gitSecrets)
            gitSecretListOutput = (gitSecretListOutput.filter { $0.count > 0 })

            guard gitSecretListOutput.count > 0 else
            {
                return ["\(pretty_function()) no secrets in repo"]
            }

            let files = try gitSecretListOutput.map { try srcRoot.file(named: $0) }

            for file in files
            {
                let gpg = try system.installOrGetProcessFromBrew(formula: "gpg", in: srcRoot)
                gpg.arguments = ["-c", file.name]

                let output = try terminal.runProcess(gpg)
                signPost.verbose(output.joined(separator: "\n"))
            }

            signPost.message("\(pretty_function()) ✅")
            try commitHiddenSecrets(in: folder)
            return files.map { $0.path }
        }
        catch
        {
            signPost.message("\(pretty_function()) \n \(error) \n ❌")
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Processes

    public func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        return try system.installOrGetProcessFromBrew(formula: SecretsWorker.gitSecretname, in: folder)
    }

    // MARK: - Error

    public indirect enum Error: Swift.Error, Equatable, CustomStringConvertible
    {
        case runSecretsExecutable(missingFilePaths: [String])
        case location(String, Error)

        public var description: String
        {
            switch self
            {
            case let .runSecretsExecutable(missingFilePaths: missingFilePaths):
                return """
                changed secret files:
                
                \(missingFilePaths.map { "    * \($0)" }.joined(separator: "\n"))
                
                ❌ secrets not commited\nYou should run ./.build/x86_64-apple-macosx10.10/release/<#Your project#>Secrets\n❌
                """
            case let .location(location, indirectError):
                return """
                
                \(indirectError)
                
                Location
                \(location)
                """
            }
        }

        public var indirect: Error?
        {
            switch self
            {
            case let .location(_, indirectError):
                return indirectError
            default:
                return nil
            }
        }
    }
}
