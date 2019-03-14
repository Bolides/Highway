import Arguments
import SourceryAutoProtocols
import Terminal
import Url
import ZFile

public struct GitTool: AutoGenerateProtocol
{
    // MARK: - Properties

    private let systemExecutableProvider: SystemExecutableProviderProtocol
    private let terminal: TerminalProtocol

    // MARK: - Init

    public init(
        systemExecutableProvider: SystemExecutableProviderProtocol = SystemExecutableProvider.shared,
        terminal: TerminalProtocol = Terminal.shared
    )
    {
        self.systemExecutableProvider = systemExecutableProvider
        self.terminal = terminal
    }

    // MARK: - Helper

    private func _git(with arguments: Arguments) throws -> Task
    {
        let task = Task(executable: try systemExecutableProvider.executable(with: "git"))
        task.arguments = arguments
        return task
    }
}

extension GitTool: GitToolProtocol
{
    public func addAll() throws
    {
        _ = try terminal.runProcess(try _git(with: ["add", "."]).toProcess)
    }

    public func commit(message: String) throws
    {
        _ = try terminal.runProcess(try _git(with: ["commit", "-m", message]).toProcess)
    }

    public func pushToMaster() throws
    {
        _ = try terminal.runProcess(try _git(with: ["push", "origin", "master"]).toProcess)
    }

    public func pushTagsToMaster() throws
    {
        _ = try terminal.runProcess(try _git(with: ["push", "--tags"]).toProcess)
    }

    public func pull() throws
    {
        _ = try terminal.runProcess(try _git(with: ["pull"]).toProcess)
    }

    public func currentTag() throws -> [String]
    {
        let task = try _git(with: ["describe", "--tags"])
        task.enableReadableOutputDataCapturing()

        return try terminal.runProcess(task.toProcess)
    }

    public func clone(with options: CloneOptions) throws -> [String]
    {
        let input: [String] = ["clone"] + (options.performMirror ? ["--mirror"] : []) + [options.remoteUrl, options.localPath.path]
        let arguments = Arguments(input)

        return try terminal.runProcess(try _git(with: arguments).toProcess)
    }
}
