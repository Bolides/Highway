import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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

    // MARK: - <generateDependency> - parameters

    public var generateDependencyThrowableError: Error?
    public var generateDependencyCallsCount = 0
    public var generateDependencyCalled: Bool
    {
        return generateDependencyCallsCount > 0
    }

    public var generateDependencyReturnValue: DependencyProtocol?

    // MARK: - <generateDependency> - closure mocks

    public var generateDependencyClosure: (() throws -> DependencyProtocol)?

    // MARK: - <generateDependency> - method mocked

    open func generateDependency() throws -> DependencyProtocol
    {
        // <generateDependency> - Throwable method implementation

        if let error = generateDependencyThrowableError
        {
            throw error
        }

        generateDependencyCallsCount += 1

        // <generateDependency> - Return Value mock implementation

        guard let closureReturn = generateDependencyClosure else
        {
            guard let returnValue = generateDependencyReturnValue else
            {
                let message = "No returnValue implemented for generateDependencyClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement DependencyProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
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

// MARK: - ProcessProtocolMock

open class ProcessProtocolMock: ProcessProtocol
{
    public init() {}

    public var standardInput: Any?
    public var standardOutput: Any?
    public var standardError: Any?
    public var terminationStatus: Int32
    {
        get { return underlyingTerminationStatus }
        set(value) { underlyingTerminationStatus = value }
    }

    public var underlyingTerminationStatus: Int32!
    public var arguments: [String]?
    public var currentDirectoryPath: String
    {
        get { return underlyingCurrentDirectoryPath }
        set(value) { underlyingCurrentDirectoryPath = value }
    }

    public var underlyingCurrentDirectoryPath: String = "AutoMockable filled value"

    // MARK: - <launch> - parameters

    public var launchCallsCount = 0
    public var launchCalled: Bool
    {
        return launchCallsCount > 0
    }

    // MARK: - <launch> - closure mocks

    public var launchClosure: (() -> Void)?

    // MARK: - <launch> - method mocked

    open func launch()
    {
        launchCallsCount += 1

        // <launch> - Void return mock implementation

        launchClosure?()
    }

    // MARK: - <waitUntilExit> - parameters

    public var waitUntilExitCallsCount = 0
    public var waitUntilExitCalled: Bool
    {
        return waitUntilExitCallsCount > 0
    }

    // MARK: - <waitUntilExit> - closure mocks

    public var waitUntilExitClosure: (() -> Void)?

    // MARK: - <waitUntilExit> - method mocked

    open func waitUntilExit()
    {
        waitUntilExitCallsCount += 1

        // <waitUntilExit> - Void return mock implementation

        waitUntilExitClosure?()
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

// MARK: - SystemProtocolMock

open class SystemProtocolMock: SystemProtocol
{
    public init() {}

    public static var shared: SystemProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: SystemProtocol!
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

    // MARK: - <process> - parameters

    public var processThrowableError: Error?
    public var processCallsCount = 0
    public var processCalled: Bool
    {
        return processCallsCount > 0
    }

    public var processReceivedExecutableName: String?
    public var processReturnValue: ProcessProtocol?

    // MARK: - <process> - closure mocks

    public var processClosure: ((String) throws -> ProcessProtocol)?

    // MARK: - <process> - method mocked

    open func process(_ executableName: String) throws -> ProcessProtocol
    {
        // <process> - Throwable method implementation

        if let error = processThrowableError
        {
            throw error
        }

        processCallsCount += 1
        processReceivedExecutableName = executableName

        // <process> - Return Value mock implementation

        guard let closureReturn = processClosure else
        {
            guard let returnValue = processReturnValue else
            {
                let message = "No returnValue implemented for processClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement ProcessProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(executableName)
    }

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
    public var toProcess: ProcessProtocol
    {
        get { return underlyingToProcess }
        set(value) { underlyingToProcess = value }
    }

    public var underlyingToProcess: ProcessProtocol!
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

    public var runProcessReceivedProcessTask: ProcessProtocol?
    public var runProcessReturnValue: [String]?

    // MARK: - <runProcess> - closure mocks

    public var runProcessClosure: ((ProcessProtocol) throws -> [String])?

    // MARK: - <runProcess> - method mocked

    open func runProcess(_ processTask: ProcessProtocol) throws -> [String]
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
