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
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
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
