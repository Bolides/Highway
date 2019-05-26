import CarthageWorker
import Errors
import Foundation
import HighwayDispatch
import Result
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - CarthageBuilderProtocolMock

open class CarthageBuilderProtocolMock: CarthageBuilderProtocol
{
    public init() {}

    public static var carthageExecutableFolderPath: String
    {
        get { return underlyingCarthageExecutableFolderPath }
        set(value) { underlyingCarthageExecutableFolderPath = value }
    }

    public static var underlyingCarthageExecutableFolderPath: String = "AutoMockable filled value"
    public static var carthageExecutableName: String
    {
        get { return underlyingCarthageExecutableName }
        set(value) { underlyingCarthageExecutableName = value }
    }

    public static var underlyingCarthageExecutableName: String = "AutoMockable filled value"

    // MARK: - <attemptBuildCarthageIfNeeded> - parameters

    public var attemptBuildCarthageIfNeededThrowableError: Error?
    public var attemptBuildCarthageIfNeededCallsCount = 0
    public var attemptBuildCarthageIfNeededCalled: Bool
    {
        return attemptBuildCarthageIfNeededCallsCount > 0
    }

    public var attemptBuildCarthageIfNeededReturnValue: FileProtocol?

    // MARK: - <attemptBuildCarthageIfNeeded> - closure mocks

    public var attemptBuildCarthageIfNeededClosure: (() throws -> FileProtocol)?

    // MARK: - <attemptBuildCarthageIfNeeded> - method mocked

    open func attemptBuildCarthageIfNeeded() throws -> FileProtocol
    {
        // <attemptBuildCarthageIfNeeded> - Throwable method implementation

        if let error = attemptBuildCarthageIfNeededThrowableError
        {
            throw error
        }

        attemptBuildCarthageIfNeededCallsCount += 1

        // <attemptBuildCarthageIfNeeded> - Return Value mock implementation

        guard let closureReturn = attemptBuildCarthageIfNeededClosure else
        {
            guard let returnValue = attemptBuildCarthageIfNeededReturnValue else
            {
                let message = "No returnValue implemented for attemptBuildCarthageIfNeededClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - HWCarthageProtocolMock

open class HWCarthageProtocolMock: HWCarthageProtocol
{
    public init() {}

    public static var queue: HighwayDispatchProtocol
    {
        get { return underlyingQueue }
        set(value) { underlyingQueue = value }
    }

    public static var underlyingQueue: HighwayDispatchProtocol!

    // MARK: - <attemptRunCarthageIfCommandLineOptionAdded> - parameters

    public var attemptRunCarthageIfCommandLineOptionAddedInCallsCount = 0
    public var attemptRunCarthageIfCommandLineOptionAddedInCalled: Bool
    {
        return attemptRunCarthageIfCommandLineOptionAddedInCallsCount > 0
    }

    public var attemptRunCarthageIfCommandLineOptionAddedInReceivedArguments: (folder: FolderProtocol, async: (@escaping HWCarthage.SyncOutput) -> Void)?

    // MARK: - <attemptRunCarthageIfCommandLineOptionAdded> - closure mocks

    public var attemptRunCarthageIfCommandLineOptionAddedInClosure: ((FolderProtocol, @escaping (@escaping HWCarthage.SyncOutput) -> Void) -> Void)?

    // MARK: - <attemptRunCarthageIfCommandLineOptionAdded> - method mocked

    open func attemptRunCarthageIfCommandLineOptionAdded(in folder: FolderProtocol, _ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        attemptRunCarthageIfCommandLineOptionAddedInCallsCount += 1
        attemptRunCarthageIfCommandLineOptionAddedInReceivedArguments = (folder: folder, async: async)

        // <attemptRunCarthageIfCommandLineOptionAdded> - Void return mock implementation

        attemptRunCarthageIfCommandLineOptionAddedInClosure?(folder, async)
    }
}

// MARK: - OBJECTIVE-C

// MARK: - Sourcery Errors

public enum SourceryMockError: Swift.Error, Hashable
{
    case implementErrorCaseFor(String)
    case subclassMockBeforeUsing(String)

    public var debugDescription: String
    {
        switch self
        {
        case let .implementErrorCaseFor(message):
            return """
            🧙‍♂️ SourceryMockError.implementErrorCaseFor:
            message: \(message)
            """
        case let .subclassMockBeforeUsing(message):
            return """
            \n
            🧙‍♂️ SourceryMockError.subclassMockBeforeUsing:
            message: \(message)
            """
        }
    }
}
