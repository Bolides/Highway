import Errors
import Foundation
import HighwayDispatch
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
    public let dispatchGroup: HWDispatchGroupProtocol

    // MARK: - Private

    private let filesystem: FileSystemProtocol

    // MARK: - Init

    public init(
        signPost: SignPostProtocol = SignPost.shared,
        dispatchGroup: HWDispatchGroupProtocol = DispatchGroup(),
        filesystem: FileSystemProtocol = FileSystem.shared
    )
    {
        self.signPost = signPost
        self.dispatchGroup = dispatchGroup
        self.filesystem = filesystem
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
        let message = "👾  \(task.rawValue): \(String(describing: processTask.executableFile))\n"
        signPost.verbose(message)

        return try runProcess(processTask)
    }

    public func runProcess(_ processTask: ProcessProtocol) throws -> [String]
    {
        return try runProcess(processTask, task: nil)
    }

    // Waits in the pipe until on output of 0 length is found and reports output on success or throws failiure
    public func runProcess(_ processTask: ProcessProtocol, task: TerminalTask?) throws -> [String]
    {
        let pipe = Pipe()
        processTask.standardOutput = pipe
        processTask.standardError = pipe

        try processTask._run()

        dispatchGroup.enter()

        var receivedError: Swift.Error?
        let outputFile = try filesystem.temporaryFolder.createFileIfNeeded(named: "be.dooz.terminal - \(UUID().uuidString)")

        pipe.fileHandleForReading.readabilityHandler = { fh in
            let data = fh.availableData
            // process data ...
            let outputData = String(data: data, encoding: String.Encoding.utf8)
            let output = outputData?.components(separatedBy: "\n")
            self.signPost.verbose(output?.joined(separator: "\n") ?? "")

            guard let result = output else
            {
                pipe.fileHandleForReading.closeFile()
                self.dispatchGroup.leave()
                return
            }

            do
            {
                try outputFile.append(string: result.joined(separator: "\n"))
                if result.count == 1, result[0].count == 0 {
                    pipe.fileHandleForReading.closeFile()
                    self.dispatchGroup.leave()
                }
                else
                {
                    self.signPost.verbose(result.joined(separator: "\n"))
                }
            }
            catch
            {
                receivedError = error
                pipe.fileHandleForReading.closeFile()
                self.dispatchGroup.leave()
            }
        }

        processTask.terminationHandler = { process in

            guard !process.isRunning else
            {
                return
            }

            let code = process.terminationStatus
            let exit = TerminalSysExitCode(rawValue: code)
            let outputIfError = ["⚠️ add --verbose to inspect error output"] + ((try? outputFile.readAllLines()) ?? [])

            guard let exitCode = exit else
            {
                if let task = task
                {
                    receivedError = Terminal.Error.errorUnkownExitCode(code: Int(processTask.terminationStatus), task: task, output: outputIfError)
                }
                else
                {
                    receivedError = Terminal.Error.unknownTask(errorOutput: ["No exit code"] + outputIfError)
                }
                return
            }

            guard exitCode == .ok else
            {
                if let task = task
                {
                    receivedError = Terminal.Error.errorExitCode(code: exitCode, task: task, output: outputIfError)
                }
                else
                {
                    receivedError = Terminal.Error.unknownTask(errorOutput: ["No exit code"] + outputIfError)
                }

                return
            }
        }

        dispatchGroup.wait()

        guard let exitError = receivedError else
        {
            let output = try outputFile.readAllLines()
            try outputFile.write(string: "")
            return output
        }

        throw exitError
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
