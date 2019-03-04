import Arguments
import SourceryAutoProtocols
import Task
import Url
import ZFile
import Terminal

public struct GitTool: AutoGenerateProtocol
{
    // MARK: - Properties
    
    private let systemExecutableProvider: SystemExecutableProviderProtocol
    private let terminal: TerminalWorkerProtocol
    
    // MARK: - Init

    public init(
        systemExecutableProvider: SystemExecutableProviderProtocol = SystemExecutableProvider.shared,
        terminal: TerminalWorkerProtocol = TerminalWorker.shared
    ) {
        self.systemExecutableProvider = systemExecutableProvider
        self.terminal = terminal
    }

    // MARK: - Helper

    private func _git(with arguments: Arguments, at url: FolderProtocol) throws -> Task
    {
        let task = Task(executable: try systemExecutableProvider.executable(with: "git"))
        task.arguments = arguments
        task.currentDirectoryUrl = url
        return task
    }
}

extension GitTool: GitToolProtocol
{
    
    public func addAll(at url: FolderProtocol) throws
    {
        _ = try terminal.runProcess(try _git(with: ["add", "."], at: url).toProcess)
    }

    public func commit(at url: FolderProtocol, message: String) throws
    {
        _ = try terminal.runProcess(try _git(with: ["commit", "-m", message], at: url).toProcess)
    }

    public func pushToMaster(at url: FolderProtocol) throws
    {
        _ = try terminal.runProcess(try _git(with: ["push", "origin", "master"], at: url).toProcess)
    }

    public func pushTagsToMaster(at url: FolderProtocol) throws
    {
        _ = try terminal.runProcess(try _git(with: ["push", "--tags"], at: url).toProcess)
    }

    public func pull(at url: FolderProtocol) throws
    {
        _ = try terminal.runProcess(try _git(with: ["pull"], at: url).toProcess)
    }

    public func currentTag(at url: FolderProtocol) throws -> [String]
    {
        let task = try _git(with: ["describe", "--tags"], at: url)
        task.enableReadableOutputDataCapturing()
        
        return  try terminal.runProcess(task.toProcess)
    }

    public func clone(with options: CloneOptions) throws -> [String]
    {
        let input: [String] = ["clone"] + (options.performMirror ? ["--mirror"] : []) + [options.remoteUrl, options.localPath.path]
        let arguments = Arguments(input)
        
        return try terminal.runProcess(try _git(with: arguments, at: try Folder(path: "/")).toProcess)
    }
    
}
