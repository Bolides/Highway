import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile

// MARK: - Terminal

public protocol TerminalProtocol: AutoMockable
{
    @discardableResult
    func terminal(task: TerminalTask) throws -> [String]

    @discardableResult
    func runExecutable(_ executable: ExecutableProtocol) throws -> [String]

    @discardableResult
    func runProcess(_ processTask: ProcessProtocol) throws -> [String]
}

public struct Terminal: TerminalProtocol
{
    public static let shared: TerminalProtocol = Terminal()

    public let signPost: SignPostProtocol

    public init(signPost: SignPostProtocol = SignPost.shared)
    {
        self.signPost = signPost
    }

    @discardableResult
    public func runExecutable(_ executable: ExecutableProtocol) throws -> [String]
    {
        let processTask = Process()
        let executableFile: FileProtocol = try executable.executableFile()
        try processTask.executable(set: executableFile)

        let message = "👾  running executable at path \(executableFile)\n"
        signPost.verbose(message)

        return try runProcess(processTask)
    }

    @discardableResult
    public func terminal(task: TerminalTask) throws -> [String]
    {
        let processTask = Process()
        processTask.arguments = try task.executable.arguments().all
        try processTask.executable(set: try task.executable.executableFile())
        let message = "👾  \(task.rawValue): \(processTask.executableFile)\n"
        signPost.verbose(message)

        return try runProcess(processTask)
    }

    public func runProcess(_ processTask: ProcessProtocol) throws -> [String]
    {
        return try runProcess(processTask, task: nil)
    }

    public func runProcess(_ processTask: ProcessProtocol, task: TerminalTask?) throws -> [String]
    {
        var finalResult = [String]()

        let pipe = Pipe()
        processTask.standardOutput = pipe
        processTask.standardError = pipe
        processTask.launch()
        processTask.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let outputData = String(data: data, encoding: String.Encoding.utf8)
        let output = outputData?.components(separatedBy: "\n")

        guard let exitCode = TerminalSysExitCode(rawValue: processTask.terminationStatus) else
        {
            if let task = task
            {
                throw Terminal.Error.errorUnkownExitCode(code: Int(processTask.terminationStatus), task: task, output: output ?? [])
            }
            else if let output = output
            {
                finalResult.append(contentsOf: output)
                throw Terminal.Error.unknownTask(errorOutput: finalResult)
            }
            else
            {
                throw Terminal.Error.unknownTask(errorOutput: ["No exit code or output"])
            }
        }

        guard exitCode == .ok else
        {
            if let task = task
            {
                throw Terminal.Error.errorExitCode(code: exitCode, task: task, output: output ?? [])
            }
            else if let output = output
            {
                finalResult.append(contentsOf: output)
                throw Terminal.Error.unknownTask(errorOutput: finalResult)
            }
            else
            {
                throw Terminal.Error.unknownTask(errorOutput: ["No exit code or output"])
            }
        }

        guard let result = output, result.count >= 2 else
        {
            if let task = task
            {
                throw Terminal.Error.emptyOutputFromTask(task)
            }
            else if let output = output
            {
                finalResult.append(contentsOf: output)
                throw Terminal.Error.unknownTask(errorOutput: finalResult)
            }
            else
            {
                throw Terminal.Error.unknownTask(errorOutput: ["No exit code or output"])
            }
        }

        finalResult.append(contentsOf: result)

        return finalResult
    }

    // MARK: - Error

    public enum Error: Swift.Error, CustomDebugStringConvertible, Equatable
    {
        case emptyOutputFromTask(TerminalTask)
        case unknownTask(errorOutput: [String])
        case errorExitCode(code: TerminalSysExitCode, task: TerminalTask, output: [String])
        case errorUnkownExitCode(code: Int, task: TerminalTask, output: [String])

        public var debugDescription: String
        {
            switch self
            {
            case let .errorUnkownExitCode(code: code, task: task, output: output):
                return """
                Terminal exit code error \(code) after \(task)
                
                output:
                
                \(output.map { " \($0)" }.joined(separator: "\n"))
                
                """
            case let .errorExitCode(code: code, task: task, output: output):
                return """
                Terminal exit code error \(code) after \(task)
                
                output:
                
                \(output.map { " \($0)" }.joined(separator: "\n"))
                
                """
            case let .emptyOutputFromTask(task):
                return "\n\(task) returned with empty output\n"
            case let .unknownTask(errorOutput: output):
                return """
                TerminalError while performing unknown task
                output:
                \(output.map { " \($0)" }.joined(separator: "\n"))
                """
            }
        }
    }
}

// MARK: - Functions

extension Process
{
    public func executableFile() throws -> FileProtocol
    {
        if #available(OSX 10.13, *)
        {
            return try File(path: executableURL?.path ?? "")
        }
        else
        {
            throw "Does not support #available(OSX 10.13, *)"
        }
    }

    public func executable(set file: FileProtocol) throws
    {
        if #available(OSX 10.13, *)
        {
            executableURL = URL(fileURLWithPath: file.path)
        }
        else
        {
            throw "Does not support #available(OSX 10.13, *)"
        }
    }
}
