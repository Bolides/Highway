import Errors
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol SecretsWorkerProtocol: AutoMockable
{
    // sourcery:inline:SecretsWorker.AutoGenerateProtocol
    static var shared: SecretsWorker { get }

    func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]

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
            let git = try system.processFromBrew(formula: "git-secret", in: folder)
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
}
