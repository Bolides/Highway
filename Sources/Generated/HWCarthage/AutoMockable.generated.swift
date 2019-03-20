import Errors
import Foundation
import HighwayDispatch
import HWCarthage
import SignPost
import SourceryAutoProtocols
import ZFile
import ZFileMock

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

    // MARK: - <attemptRunCarthage> - parameters

    public var attemptRunCarthageInCallsCount = 0
    public var attemptRunCarthageInCalled: Bool
    {
        return attemptRunCarthageInCallsCount > 0
    }

    public var attemptRunCarthageInReceivedArguments: (folder: FolderProtocol, async: (@escaping HWCarthage.SyncOutput) -> Void)?

    // MARK: - <attemptRunCarthage> - closure mocks

    public var attemptRunCarthageInClosure: ((FolderProtocol, @escaping (@escaping HWCarthage.SyncOutput) -> Void) -> Void)?

    // MARK: - <attemptRunCarthage> - method mocked

    open func attemptRunCarthage(in folder: FolderProtocol, _ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        attemptRunCarthageInCallsCount += 1
        attemptRunCarthageInReceivedArguments = (folder: folder, async: async)

        // <attemptRunCarthage> - Void return mock implementation

        attemptRunCarthageInClosure?(folder, async)
    }
}

// MARK: - OBJECTIVE-C
