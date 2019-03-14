import Arguments
import Foundation
import SourceryAutoProtocols
import Terminal
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - ArgumentExecutableProtocolMock

open class ArgumentExecutableProtocolMock: ArgumentExecutableProtocol
{
    public init() {}

    // MARK: - <arguments> - parameters

    public var argumentsThrowableError: Error?
    public var argumentsCallsCount = 0
    public var argumentsCalled: Bool
    {
        return argumentsCallsCount > 0
    }

    public var argumentsReturnValue: Arguments?

    // MARK: - <arguments> - closure mocks

    public var argumentsClosure: (() throws -> Arguments)?

    // MARK: - <arguments> - method mocked

    open func arguments() throws -> Arguments
    {
        // <arguments> - Throwable method implementation

        if let error = argumentsThrowableError
        {
            throw error
        }

        argumentsCallsCount += 1

        // <arguments> - Return Value mock implementation

        guard let closureReturn = argumentsClosure else
        {
            guard let returnValue = argumentsReturnValue else
            {
                let message = "No returnValue implemented for argumentsClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement Arguments

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <executableFile> - parameters

    public var executableFileThrowableError: Error?
    public var executableFileCallsCount = 0
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
                let message = "No returnValue implemented for executableFileClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - DependencyServiceProtocolMock

open class DependencyServiceProtocolMock: DependencyServiceProtocol
{
    public init() {}

    public var dependency: DependencyProtocol
    {
        get { return underlyingDependency }
        set(value) { underlyingDependency = value }
    }

    public var underlyingDependency: DependencyProtocol!

    // MARK: - <init> - parameters

    public var initTerminalSignPostThrowableError: Error?
    public var initTerminalSignPostReceivedArguments: (terminal: TerminalProtocol, signPost: SignPostProtocol)?

    // MARK: - <init> - closure mocks

    public var initTerminalSignPostClosure: ((TerminalProtocol, SignPostProtocol) throws -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(terminal: TerminalProtocol, signPost: SignPostProtocol) throws
    {
        initTerminalSignPostReceivedArguments = (terminal: terminal, signPost: signPost)
        try? initTerminalSignPostClosure?(terminal, signPost)
    }

    // MARK: - <writeToStubFile> - parameters

    public var writeToStubFileThrowableError: Error?
    public var writeToStubFileCallsCount = 0
    public var writeToStubFileCalled: Bool
    {
        return writeToStubFileCallsCount > 0
    }

    // MARK: - <writeToStubFile> - closure mocks

    public var writeToStubFileClosure: (() throws -> Void)?

    // MARK: - <writeToStubFile> - method mocked

    open func writeToStubFile() throws
    {
        // <writeToStubFile> - Throwable method implementation

        if let error = writeToStubFileThrowableError
        {
            throw error
        }

        writeToStubFileCallsCount += 1

        // <writeToStubFile> - Void return mock implementation

        try writeToStubFileClosure?()
    }
}

// MARK: - DumpServiceProtocolMock

open class DumpServiceProtocolMock: DumpServiceProtocol
{
    public init() {}

    public var dump: DumpProtocol
    {
        get { return underlyingDump }
        set(value) { underlyingDump = value }
    }

    public var underlyingDump: DumpProtocol!

    // MARK: - <init> - parameters

    public var initTerminalSwiftPackageDependenciesThrowableError: Error?
    public var initTerminalSwiftPackageDependenciesReceivedArguments: (terminal: TerminalProtocol, swiftPackageDependencies: DependencyProtocol)?

    // MARK: - <init> - closure mocks

    public var initTerminalSwiftPackageDependenciesClosure: ((TerminalProtocol, DependencyProtocol) throws -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(terminal: TerminalProtocol, swiftPackageDependencies: DependencyProtocol) throws
    {
        initTerminalSwiftPackageDependenciesReceivedArguments = (terminal: terminal, swiftPackageDependencies: swiftPackageDependencies)
        try? initTerminalSwiftPackageDependenciesClosure?(terminal, swiftPackageDependencies)
    }

    // MARK: - <writeToStubFile> - parameters

    public var writeToStubFileThrowableError: Error?
    public var writeToStubFileCallsCount = 0
    public var writeToStubFileCalled: Bool
    {
        return writeToStubFileCallsCount > 0
    }

    // MARK: - <writeToStubFile> - closure mocks

    public var writeToStubFileClosure: (() throws -> Void)?

    // MARK: - <writeToStubFile> - method mocked

    open func writeToStubFile() throws
    {
        // <writeToStubFile> - Throwable method implementation

        if let error = writeToStubFileThrowableError
        {
            throw error
        }

        writeToStubFileCallsCount += 1

        // <writeToStubFile> - Void return mock implementation

        try writeToStubFileClosure?()
    }
}

// MARK: - ExecutableProtocolMock

open class ExecutableProtocolMock: ExecutableProtocol
{
    public init() {}

    // MARK: - <executableFile> - parameters

    public var executableFileThrowableError: Error?
    public var executableFileCallsCount = 0
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
                let message = "No returnValue implemented for executableFileClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - PathEnvironmentParserProtocolMock

open class PathEnvironmentParserProtocolMock: PathEnvironmentParserProtocol
{
    public init() {}

    public var urls: [FolderProtocol] = []
}

// MARK: - SystemExecutableProviderProtocolMock

open class SystemExecutableProviderProtocolMock: SystemExecutableProviderProtocol
{
    public init() {}

    public static var shared: SystemExecutableProviderProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: SystemExecutableProviderProtocol!
    public var pathEnvironmentParser: PathEnvironmentParserProtocol
    {
        get { return underlyingPathEnvironmentParser }
        set(value) { underlyingPathEnvironmentParser = value }
    }

    public var underlyingPathEnvironmentParser: PathEnvironmentParserProtocol!
    public var fileSystem: FileSystemProtocol
    {
        get { return underlyingFileSystem }
        set(value) { underlyingFileSystem = value }
    }

    public var underlyingFileSystem: FileSystemProtocol!

    // MARK: - <executable> - parameters

    public var executableWithThrowableError: Error?
    public var executableWithCallsCount = 0
    public var executableWithCalled: Bool
    {
        return executableWithCallsCount > 0
    }

    public var executableWithReceivedExecutableName: String?
    public var executableWithReturnValue: FileProtocol?

    // MARK: - <executable> - closure mocks

    public var executableWithClosure: ((String) throws -> FileProtocol)?

    // MARK: - <executable> - method mocked

    open func executable(with executableName: String) throws -> FileProtocol
    {
        // <executable> - Throwable method implementation

        if let error = executableWithThrowableError
        {
            throw error
        }

        executableWithCallsCount += 1
        executableWithReceivedExecutableName = executableName

        // <executable> - Return Value mock implementation

        guard let closureReturn = executableWithClosure else
        {
            guard let returnValue = executableWithReturnValue else
            {
                let message = "No returnValue implemented for executableWithClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(executableName)
    }
}

// MARK: - TaskProtocolMock

open class TaskProtocolMock: TaskProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var executable: FileProtocol
    {
        get { return underlyingExecutable }
        set(value) { underlyingExecutable = value }
    }

    public var underlyingExecutable: FileProtocol!
    public var arguments: Arguments
    {
        get { return underlyingArguments }
        set(value) { underlyingArguments = value }
    }

    public var underlyingArguments: Arguments!
    public var input: Channel
    {
        get { return underlyingInput }
        set(value) { underlyingInput = value }
    }

    public var underlyingInput: Channel!
    public var output: Channel
    {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }

    public var underlyingOutput: Channel!
    public var capturedOutputData: Data?
    public var readOutputString: String?
    public var trimmedOutput: String?
    public var capturedOutputString: String?
    public var toProcess: Process
    {
        get { return underlyingToProcess }
        set(value) { underlyingToProcess = value }
    }

    public var underlyingToProcess: Process!
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <enableReadableOutputDataCapturing> - parameters

    public var enableReadableOutputDataCapturingCallsCount = 0
    public var enableReadableOutputDataCapturingCalled: Bool
    {
        return enableReadableOutputDataCapturingCallsCount > 0
    }

    // MARK: - <enableReadableOutputDataCapturing> - closure mocks

    public var enableReadableOutputDataCapturingClosure: (() -> Void)?

    // MARK: - <enableReadableOutputDataCapturing> - method mocked

    open func enableReadableOutputDataCapturing()
    {
        enableReadableOutputDataCapturingCallsCount += 1

        // <enableReadableOutputDataCapturing> - Void return mock implementation

        enableReadableOutputDataCapturingClosure?()
    }
}

// MARK: - TerminalProtocolMock

open class TerminalProtocolMock: TerminalProtocol
{
    public init() {}

    // MARK: - <terminal> - parameters

    public var terminalTaskThrowableError: Error?
    public var terminalTaskCallsCount = 0
    public var terminalTaskCalled: Bool
    {
        return terminalTaskCallsCount > 0
    }

    public var terminalTaskReceivedTask: TerminalTask?
    public var terminalTaskReturnValue: [String]?

    // MARK: - <terminal> - closure mocks

    public var terminalTaskClosure: ((TerminalTask) throws -> [String])?

    // MARK: - <terminal> - method mocked

    open func terminal(task: TerminalTask) throws -> [String]
    {
        // <terminal> - Throwable method implementation

        if let error = terminalTaskThrowableError
        {
            throw error
        }

        terminalTaskCallsCount += 1
        terminalTaskReceivedTask = task

        // <terminal> - Return Value mock implementation

        guard let closureReturn = terminalTaskClosure else
        {
            guard let returnValue = terminalTaskReturnValue else
            {
                let message = "No returnValue implemented for terminalTaskClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(task)
    }

    // MARK: - <runExecutable> - parameters

    public var runExecutableThrowableError: Error?
    public var runExecutableCallsCount = 0
    public var runExecutableCalled: Bool
    {
        return runExecutableCallsCount > 0
    }

    public var runExecutableReceivedExecutable: ExecutableProtocol?
    public var runExecutableReturnValue: [String]?

    // MARK: - <runExecutable> - closure mocks

    public var runExecutableClosure: ((ExecutableProtocol) throws -> [String])?

    // MARK: - <runExecutable> - method mocked

    open func runExecutable(_ executable: ExecutableProtocol) throws -> [String]
    {
        // <runExecutable> - Throwable method implementation

        if let error = runExecutableThrowableError
        {
            throw error
        }

        runExecutableCallsCount += 1
        runExecutableReceivedExecutable = executable

        // <runExecutable> - Return Value mock implementation

        guard let closureReturn = runExecutableClosure else
        {
            guard let returnValue = runExecutableReturnValue else
            {
                let message = "No returnValue implemented for runExecutableClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(executable)
    }

    // MARK: - <runProcess> - parameters

    public var runProcessThrowableError: Error?
    public var runProcessCallsCount = 0
    public var runProcessCalled: Bool
    {
        return runProcessCallsCount > 0
    }

    public var runProcessReceivedProcessTask: Process?
    public var runProcessReturnValue: [String]?

    // MARK: - <runProcess> - closure mocks

    public var runProcessClosure: ((Process) throws -> [String])?

    // MARK: - <runProcess> - method mocked

    open func runProcess(_ processTask: Process) throws -> [String]
    {
        // <runProcess> - Throwable method implementation

        if let error = runProcessThrowableError
        {
            throw error
        }

        runProcessCallsCount += 1
        runProcessReceivedProcessTask = processTask

        // <runProcess> - Return Value mock implementation

        guard let closureReturn = runProcessClosure else
        {
            guard let returnValue = runProcessReturnValue else
            {
                let message = "No returnValue implemented for runProcessClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(processTask)
    }
}

// MARK: - OBJECTIVE-C
