import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol ProcessProtocol: class, AutoMockable
{
    var standardInput: Any? { get set }
    var standardOutput: Any? { get set }
    var standardError: Any? { get set }
    var terminationStatus: Int32 { get }

    func launch()
    func waitUntilExit()
}

public protocol TaskProtocol: AutoMockable
{
    // sourcery:inline:Task.AutoGenerateProtocol
    var name: String { get }
    var executable: FileProtocol { get set }
    var arguments: Arguments { get set }
    var input: Channel { get set }
    var output: Channel { get set }
    var capturedOutputData: Data? { get }
    var readOutputString: String? { get }
    var trimmedOutput: String? { get }
    var capturedOutputString: String? { get }
    var toProcess: ProcessProtocol { get }
    var description: String { get }

    func enableReadableOutputDataCapturing()

    // sourcery:end
}

public class Task: TaskProtocol, AutoGenerateProtocol
{
    // MARK: - Properties

    public var name: String { return executable.name }
    public var executable: FileProtocol
    public var arguments: Arguments

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let fileSystem: FileSystemProtocol

    // MARK: - Init

    public convenience init(commandName: String, arguments: Arguments = Arguments([]), fileSystem: FileSystemProtocol = FileSystem.shared, provider: SystemExecutableProviderProtocol = SystemExecutableProvider.shared, signPost: SignPostProtocol = SignPost.shared) throws
    {
        self.init(
            executable: try provider.executable(with: commandName),
            arguments: arguments,
            fileSystem: fileSystem,
            signPost: signPost
        )
    }

    public init(executable: FileProtocol, arguments: Arguments = Arguments([]), fileSystem: FileSystemProtocol = FileSystem.shared, signPost: SignPostProtocol = SignPost.shared)
    {
        self.executable = executable
        self.arguments = arguments
        self.fileSystem = fileSystem
        self.signPost = signPost
    }

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

    public var toProcess: ProcessProtocol
    {
        let result = Process()
        result.arguments = arguments.all
        result.launchPath = executable.path
        result.currentDirectoryPath = fileSystem.currentFolder.path

        result.environment = ProcessInfo.processInfo.environment

        return result
    }

    // MARK: - Private

    private var io = IO()
}

extension Process: ProcessProtocol
{}

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
