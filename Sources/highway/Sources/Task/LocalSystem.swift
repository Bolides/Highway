import Foundation
import Result
import SignPost
import SourceryAutoProtocols
import ZFile
import Errors

public final class LocalSystem: SystemProtocol, AutoGenerateProtocol
{
    // MARK: - Properties

    private let executor: SystemExecutorProtocol
    private let executableProvider: ExecutableProviderProtocol
    private let fileSystem: FileSystemProtocol

    // MARK: - Init

    public init(executor: SystemExecutorProtocol, executableProvider: ExecutableProviderProtocol, fileSystem: FileSystemProtocol = FileSystem.shared)
    {
        self.executor = executor
        self.executableProvider = executableProvider
        self.fileSystem = fileSystem
    }

    /// Local System
    public init(executableProvider: SystemExecutableProvider? = nil, signPost: SignPostProtocol = SignPost.shared) throws
    {
        executor = SystemExecutor(signPost: signPost)
        self.executableProvider = (executableProvider == nil) ? try SystemExecutableProvider() : executableProvider!
        fileSystem = FileSystem()
    }
}

extension LocalSystem
{
    // MARK: - Working with the System

    public func task(named name: String) throws -> Task
    {
        return Task(executable: try executableProvider.executable(with: name))
    }

    public func execute(_ task: TaskProtocol) throws -> Bool
    {
        return try launch(task, wait: true)
    }

    public func launch(_ task: TaskProtocol, wait: Bool) throws -> Bool
    {
        try executor.launch(task: task, wait: wait)

        guard wait else { return true }

        switch task.successfullyFinished {
        case false:
            throw HighwayError.failedToCompleteTask("\(task)")
        case true:
            return true
        }
    }
}
