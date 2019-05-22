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

    // MARK: - Secret changes

    public mutating func didSecretsChangeSinceLastPush(in folder: FolderProtocol) throws -> Bool
    {
        do
        {
            let gitSecretList = try gitSecretProcess(in: folder)
            gitSecretList.arguments = ["list"]

            let listOutput = try terminal.runProcess(gitSecretList).filter { !$0.isEmpty }

            let list = try listOutput.map { try folder.file(named: $0) }
            var listDates = [String: Date]()

            list.forEach { listDates[$0.path] = $0.modificationDate }

            let fileDates = try folder.createFileIfNeeded(named: SecretsWorker.secretFileDateChangePath)

            let original = try? JSONDecoder().decode(Secret.self, from: try fileDates.read())

            secretSaved = Secret(secretFileDates: listDates)

            let result = try original?.secretFileDates.filter
            {
                guard let date = secretSaved?.secretFileDates[$0.key] else
                {
                    throw HighwayError.highwayError(atLocation: pretty_function(), error: "missing secret file date \($0.key)")
                }

                return date > $0.value
            }

            guard (result?.keys.count ?? 0) > 0 else
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
                return "You should run ()"
            }
        }
    }
}
