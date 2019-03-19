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

    public static var carthageExecutablePath: String
    {
        get { return underlyingCarthageExecutablePath }
        set(value) { underlyingCarthageExecutablePath = value }
    }

    public static var underlyingCarthageExecutablePath: String = "AutoMockable filled value"

    // MARK: - <attempt> - parameters

    public var attemptThrowableError: Error?
    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReturnValue: FileProtocol?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: (() throws -> FileProtocol)?

    // MARK: - <attempt> - method mocked

    open func attempt() throws -> FileProtocol
    {
        // <attempt> - Throwable method implementation

        if let error = attemptThrowableError
        {
            throw error
        }

        attemptCallsCount += 1

        // <attempt> - Return Value mock implementation

        guard let closureReturn = attemptClosure else
        {
            guard let returnValue = attemptReturnValue else
            {
                let message = "No returnValue implemented for attemptClosure"
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

    // MARK: - <attemptToBuildCarthageIfNeeded> - parameters

    public var attemptToBuildCarthageIfNeededCallsCount = 0
    public var attemptToBuildCarthageIfNeededCalled: Bool
    {
        return attemptToBuildCarthageIfNeededCallsCount > 0
    }

    public var attemptToBuildCarthageIfNeededReceivedAsync: ((@escaping HWCarthage.SyncOutput) -> Void)?

    // MARK: - <attemptToBuildCarthageIfNeeded> - closure mocks

    public var attemptToBuildCarthageIfNeededClosure: ((@escaping (@escaping HWCarthage.SyncOutput) -> Void) -> Void)?

    // MARK: - <attemptToBuildCarthageIfNeeded> - method mocked

    open func attemptToBuildCarthageIfNeeded(_ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        attemptToBuildCarthageIfNeededCallsCount += 1
        attemptToBuildCarthageIfNeededReceivedAsync = async

        // <attemptToBuildCarthageIfNeeded> - Void return mock implementation

        attemptToBuildCarthageIfNeededClosure?(async)
    }
}

// MARK: - OBJECTIVE-C
