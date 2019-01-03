import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols

public protocol SystemExecutorProtocol: AutoMockable
{
    /// sourcery:inline:SystemExecutor.AutoGenerateProtocol
    var signPost: SignPostProtocol { get set }

    func launch(task: Task, wait: Bool) throws
    /// sourcery:end
}

public extension SystemExecutorProtocol
{
    public func execute(task: Task) throws
    {
        try launch(task: task, wait: true)
    }
}

public final class SystemExecutor: SystemExecutorProtocol, AutoGenerateProtocol
{
    public var signPost: SignPostProtocol

    // MARK: - Init

    public init(signPost: SignPostProtocol = SignPost.shared)
    {
        self.signPost = signPost
    }

    // MARK: - Working with the Executor

    public func launch(task: Task, wait: Bool) throws
    {
        let process = task.toProcess
        signPost.verbose(task.description)
        task.state = .executing
        process.launch()
        if wait
        {
            process.waitUntilExit()
        }
        if task.successfullyFinished == false
        {
            signPost.error(task.state.description)
        }
        else
        {
            signPost.verbose(task.state.description)
        }
    }
}

private extension Process
{
    func takeIOFrom(_ task: Task)
    {
        standardInput = task.input.asProcessChannel
        standardOutput = task.output.asProcessChannel
    }
}

// internal because it is tested
extension Task
{
    // sourcery:skipProtocol
    var toProcess: Process
    {
        let result = Process()
        result.arguments = arguments.all
        result.launchPath = executable.path
        if let currentDirectoryPath = currentDirectoryUrl?.path
        {
            result.currentDirectoryPath = currentDirectoryPath
        }
        var _environment: [String: String] = ProcessInfo.processInfo.environment
        environment.forEach
        {
            _environment[$0.key] = $0.value
        }
        result.environment = _environment
        result.terminationHandler = { terminatedProcess in
            self.state = .terminated(Termination(describing: terminatedProcess))
        }
        result.takeIOFrom(self)
        return result
    }
}
