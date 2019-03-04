import Arguments
import Foundation
import os
import SignPost
import SourceryAutoProtocols
import Task
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - PathEnvironmentParserProtocolMock

open class PathEnvironmentParserProtocolMock: PathEnvironmentParserProtocol
{
    public init() {}

    public static var shared: PathEnvironmentParserProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: PathEnvironmentParserProtocol!
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
    public var environment: [String: String] = [:]
    public var currentDirectoryUrl: FolderProtocol?
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
    public var state: State
    {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }

    public var underlyingState: State!
    public var capturedOutputData: Data?
    public var readOutputString: String?
    public var trimmedOutput: String?
    public var capturedOutputString: String?
    public var successfullyFinished: Bool
    {
        get { return underlyingSuccessfullyFinished }
        set(value) { underlyingSuccessfullyFinished = value }
    }

    public var underlyingSuccessfullyFinished: Bool = false
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

    // MARK: - <throwIfNotSuccess> - parameters

    public var throwIfNotSuccessThrowableError: Error?
    public var throwIfNotSuccessCallsCount = 0
    public var throwIfNotSuccessCalled: Bool
    {
        return throwIfNotSuccessCallsCount > 0
    }

    public var throwIfNotSuccessReceivedError: Swift.Error?

    // MARK: - <throwIfNotSuccess> - closure mocks

    public var throwIfNotSuccessClosure: ((Swift.Error) throws -> Void)?

    // MARK: - <throwIfNotSuccess> - method mocked

    open func throwIfNotSuccess(_ error: Swift.Error) throws
    {
        // <throwIfNotSuccess> - Throwable method implementation

        if let error = throwIfNotSuccessThrowableError
        {
            throw error
        }

        throwIfNotSuccessCallsCount += 1
        throwIfNotSuccessReceivedError = error

        // <throwIfNotSuccess> - Void return mock implementation

        try throwIfNotSuccessClosure?(error)
    }
}

// MARK: - OBJECTIVE-C
