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
    static var secretFileDateChangePath: String { get set }

    func revealSecrets(in folder: FolderProtocol) throws -> [String]
    mutating func didSecretsChangeSinceLastPush(in folder: FolderProtocol) throws -> Bool
    mutating func writeNewSecretSavedData(in folder: FolderProtocol) throws
    mutating func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    func commitHiddenSecrets(in folder: FolderProtocol) throws -> [String]
    mutating func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol

    // sourcery:end
}

public struct SecretsWorker: SecretsWorkerProtocol, AutoGenerateProtocol
{
    public static let shared = SecretsWorker()
    public static var gitSecretname = "git-secret"
    public static var secretFileDateChangePath = ".secretsChangeDates.json"

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol
    private var secretSaved: Secret?
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

    // MARK: - Seret reveal

    /// reveals secrets if they are not already revealed
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

    /// Returns with true if the secrets listed by git secret have changed
    /// It stores a file with json named SecretsWorker.secretFileDateChangePath in the root folder
    /// later it checks for dates with keys of the relative paths to the secrets files and returns with false if files have changed.
    public mutating func didSecretsChangeSinceLastPush(in folder: FolderProtocol) throws -> Bool
    {
        do
        {
            let gitSecretList = try gitSecretProcess(in: folder)
            gitSecretList.arguments = ["list"]

            let listOutput = try terminal.runProcess(gitSecretList).filter { !$0.isEmpty }

            let rootPath = folder.path
            let list = try listOutput.map { try folder.file(named: $0) }
            var listDates = [String: Date]()

            list.forEach
            {
                let relativePath = $0.path.replacingOccurrences(of: rootPath, with: "")
                listDates[relativePath] = $0.modificationDate
            }

            let fileDates = try folder.createFileIfNeeded(named: SecretsWorker.secretFileDateChangePath)
            secretSaved = Secret(secretFileDates: listDates)

            guard let original = (try? JSONDecoder().decode(Secret.self, from: try fileDates.read())) else
            {
                try writeNewSecretSavedData(in: folder)
                return true
            }

            let result = try original.secretFileDates.filter
            {
                guard let date = secretSaved?.secretFileDates[$0.key] else
                {
                    throw HighwayError.highwayError(atLocation: pretty_function(), error: "missing secret file date \($0.key)")
                }

                return date > $0.value
            }

            guard result.keys.count > 0 else
            {
                secretSaved = nil
                return false
            }

            return true
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    /// Writes cached in memory private secretSaved to disk and sets it to nil
    /// Output can be found in root folder json file named SecretsWorker.secretFileDateChangePath.
    public mutating func writeNewSecretSavedData(in folder: FolderProtocol) throws
    {
        guard let secretSaved = secretSaved else
        {
            return
        }

        let secretData = try JSONEncoder().encode(secretSaved)
        let fileDates = try folder.createFileIfNeeded(named: SecretsWorker.secretFileDateChangePath)
        try fileDates.write(data: secretData)
        self.secretSaved = nil
    }

    // MARK: - git-secret

    // Will throw to make you run secrets to hide secrets with git-secret ang gpg
    public mutating func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    {
        guard try didSecretsChangeSinceLastPush(in: folder) else
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
            signPost.message("\(pretty_function()) ❌")

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
            gitAdd.arguments?.append(SecretsWorker.secretFileDateChangePath)

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

    public mutating func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    {
        guard try didSecretsChangeSinceLastPush(in: folder) else
        {
            return ["\(pretty_function()) no secrets changed, skipping!"]
        }

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
            try commitHiddenSecrets(in: folder)
            return files.map { $0.path }
        }
        catch
        {
            signPost.message("\(pretty_function()) ❌")
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Processes

    public func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        return try system.installOrGetProcessFromBrew(formula: SecretsWorker.gitSecretname, in: folder)
    }

    // MARK: - Error

    public enum Error: Swift.Error, Equatable, CustomStringConvertible
    {
        case runSecretsExecutable

        public var description: String
        {
            switch self
            {
            case .runSecretsExecutable:
                return "❌ secrets not commited\nYou should run ./.build/x86_64-apple-macosx10.10/release/<#Your project#>Secrets\n❌"
            }
        }
    }
}
