import Foundation
import os
import SourceryAutoProtocols
import ZFile
import SignPost

// MARK: - TerminalWorker

public protocol TerminalWorkerProtocol: AutoMockable {
    @discardableResult
    func terminal(task: TerminalTask) throws -> [String]
}

public struct TerminalWorker: TerminalWorkerProtocol {
    
    public let signPost: SignPostProtocol
    
    public init(signPost: SignPostProtocol = SignPost.shared) {
        self.signPost = signPost
    }
    
    @discardableResult
    public func terminal(task: TerminalTask) throws -> [String] {
        var finalResult = [String]()
                
        let processTask = Process()
        processTask.arguments = try task.executable.arguments().all
        try processTask.executable(set: try task.executable.executableFile())
        
        let message = "👾  \(task.rawValue): \(processTask.executableFile)\n"
        
        signPost.message(message)
        
        let pipe = Pipe()
        processTask.standardOutput = pipe
        processTask.standardError = pipe
        processTask.launch()
        processTask.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let outputData = String(data: data, encoding: String.Encoding.utf8)
        let output = outputData?.components(separatedBy: "\n")
        
        guard let exitCode = TerminalSysExitCode(rawValue: processTask.terminationStatus) else {
            throw TerminalWorker.Error.errorUnkownExitCode(code: Int(processTask.terminationStatus), task: task, output: output ?? [])
        }
        
        guard exitCode == .ok else {
            throw TerminalWorker.Error.errorExitCode(code: exitCode, task: task, output: output ?? [])
        }
        
        guard let result = output, result.count >= 2 else {
            throw TerminalWorker.Error.emptyOutputFromTask(task)
        }
        
        finalResult.append(contentsOf: result)
        
        return finalResult
        
    }
    
    // MARK: - Error
    
    public enum Error: Swift.Error, CustomDebugStringConvertible, Equatable {
        case emptyOutputFromTask(TerminalTask)
        case unknownTask(errorOutput: [String])
        case errorExitCode(code: TerminalSysExitCode, task: TerminalTask, output: [String])
        case errorUnkownExitCode(code: Int, task: TerminalTask, output: [String])
        
        public var debugDescription: String {
            switch self {
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


extension Process {
    public var executableFile: FileProtocol {
        return try! File(path: executableURL?.path ?? "")
    }
    
    public func executable(set file: FileProtocol) throws {
        executableURL = URL(fileURLWithPath: file.path)
    }
}
