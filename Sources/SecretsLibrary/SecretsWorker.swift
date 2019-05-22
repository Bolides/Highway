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

    
    public func didSecretsChangeSinceLastPush(in folder: FolderProtocol) throws -> Bool {
        
        do {
            let gitSecretList = try gitSecretProcess(in: folder)
            gitSecretList.arguments = ["list"]
            
            let listOutput = try terminal.runProcess(gitSecretList).filter { !$0.isEmpty }
            
            let list = try listOutput.map { try folder.file(named: $0) }
            var listDates = [String: Date]()
            
            list.forEach { listDates[$0.path] = $0.modificationDate }
            
            let fileDates = try folder.createFileIfNeeded(named: ".secretsChangeDates.json")

            let original = try? JSONDecoder().decode(Secret.self, from: try fileDates.read())
            
            let secret = Secret(secretFileDates: listDates)
            
            let secretData = try JSONEncoder().encode(secret)
            
            
            let result = try original?.secretFileDates.filter {
                
                guard let date = secret.secretFileDates[$0.key] else {
                    throw HighwayError.highwayError(atLocation: pretty_function(), error: "missing secret file date \($0.key)")
                }
                
                return date > $0.value
            }
            
            guard (result?.keys.count ?? 0) > 0 else {
                return false
            }
            try fileDates.write(data: secretData)

            return true
            
        } catch {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
    

    public func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    {
        
        guard try didSecretsChangeSinceLastPush(in: folder) else {
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
            try commitHiddenSecrets(in: folder)
            return files.map { $0.path }
        }
        catch
        {
            signPost.message("\(pretty_function()) ❌")
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        return try system.installOrGetProcessFromBrew(formula: SecretsWorker.gitSecretname, in: folder)
    }
}
