import Arguments
import Foundation
import os
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
}

// MARK: - SwiftPackageDependencyServiceProtocolMock

open class SwiftPackageDependencyServiceProtocolMock: SwiftPackageDependencyServiceProtocol
{
    public init() {}
}

// MARK: - SwiftPackageDumpServiceProtocolMock

open class SwiftPackageDumpServiceProtocolMock: SwiftPackageDumpServiceProtocol
{
    public init() {}
}

// MARK: - SystemExecutableProviderProtocolMock

open class SystemExecutableProviderProtocolMock: SystemExecutableProviderProtocol
{
    public init() {}
}

// MARK: - TaskProtocolMock

open class TaskProtocolMock: TaskProtocol
{
    public init() {}
}

// MARK: - TerminalWorkerProtocolMock

open class TerminalWorkerProtocolMock: TerminalWorkerProtocol
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
