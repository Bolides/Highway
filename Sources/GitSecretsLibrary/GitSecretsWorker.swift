import Errors
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol GitSecretWorkerProtocol: AutoMockable
{
    // sourcery:inline:GitSecretWorker.AutoGenerateProtocol

    func attemptHideSecrets(in folder: FolderProtocol) throws

    // sourcery:end
}

public struct GitSecretWorker: GitSecretWorkerProtocol, AutoGenerateProtocol
{
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
    public func attemptHideSecrets(in folder: FolderProtocol) throws
    {
        signPost.message("\(pretty_function()) ...")

        do
        {
            let git = try system.processFromBrew(formula: "git-secret", in: folder)
            git.arguments = ["hide"]

            let output = try terminal.runProcess(git)
            signPost.verbose("\(output.joined(separator: "\n"))")
            signPost.message("\(pretty_function()) ✅")
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
