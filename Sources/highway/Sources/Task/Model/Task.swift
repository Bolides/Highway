import Arguments
import Foundation
import SourceryAutoProtocols
import ZFile

public protocol TaskProtocol: AutoMockable
{
    /// sourcery:inline:Task.AutoGenerateProtocol
    var name: String { get }
    var executable: FileProtocol { get set }
    var arguments: Arguments { get set }
    var environment: [String: String] { get set }
    var currentDirectoryUrl: FolderProtocol? { get set }
    var input: Channel { get set }
    var output: Channel { get set }
    var state: State { get set }
    var capturedOutputData: Data? { get }
    var readOutputString: String? { get }
    var trimmedOutput: String? { get }
    var capturedOutputString: String? { get }
    var successfullyFinished: Bool { get }
    var toProcess: Process { get }
    var description: String { get }

    func enableReadableOutputDataCapturing()
    func throwIfNotSuccess(_ error: Swift.Error) throws 
    /// sourcery:end
}

public class Task: TaskProtocol, AutoGenerateProtocol
{
    // MARK: - Init

    public convenience init(commandName: String, arguments: Arguments = Arguments(), currentDirectoryUrl: FolderProtocol? = nil, provider: SystemExecutableProviderProtocol) throws
    {
        self.init(
            executable: try provider.executable(with: commandName),
            arguments: arguments,
            currentDirectoryUrl: currentDirectoryUrl
        )
    }

    public init(executable: FileProtocol, arguments: Arguments = Arguments(), currentDirectoryUrl: FolderProtocol? = nil)
    {
        self.executable = executable
        state = .waiting
        self.arguments = arguments
        self.currentDirectoryUrl = currentDirectoryUrl
    }

    // MARK: - Properties

    public var name: String { return executable.name }
    public var executable: FileProtocol
    public var arguments = Arguments()
    public var environment = [String: String]()
    public var currentDirectoryUrl: FolderProtocol?

    public var input: Channel
    {
        get { return io.input }
        set { io.input = newValue }
    }

    public var output: Channel
    {
        get { return io.output }
        set { io.output = newValue }
    }

    public var state: State
    public func enableReadableOutputDataCapturing()
    {
        io.enableReadableOutputDataCapturing()
    }

    public var capturedOutputData: Data? { return io.readOutputData }

    public var readOutputString: String?
    {
        return capturedOutputString
    }

    public var trimmedOutput: String?
    {
        return capturedOutputString?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var capturedOutputString: String?
    {
        guard let data = capturedOutputData else
        {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    public var successfullyFinished: Bool
    {
        return state.successfullyFinished
    }

    public func throwIfNotSuccess(_ error: Swift.Error) throws
    {
        guard successfullyFinished else
        {
            throw "🛣 🔥 \(name) with customError: \n \(error).\n"
        }
    }

    public var toProcess: Process
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

    // MARK: - Private

    private var io = IO()
}

extension Task: CustomStringConvertible
{
    public var description: String
    {
        return """
        
        TASK
        
        \(name):
        \(arguments.all.map { " *   \($0)" }.joined(separator: "\n"))
        
        OUTPUT
        
        \(String(describing: capturedOutputString))
        
        """
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
