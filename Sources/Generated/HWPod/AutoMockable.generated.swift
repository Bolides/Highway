import Errors
import Foundation
import HighwayDispatch
import HWPod
import SignPost
import SourceryAutoProtocols
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - PodInstallWorkerProtocolMock

open class PodInstallWorkerProtocolMock: PodInstallWorkerProtocol
{
    public init() {}

    public static var expectedCocoapodsVersion: String
    {
        get { return underlyingExpectedCocoapodsVersion }
        set(value) { underlyingExpectedCocoapodsVersion = value }
    }

    public static var underlyingExpectedCocoapodsVersion: String = "AutoMockable filled value"

    // MARK: - <attempt> - parameters

    public var attemptThrowableError: Error?
    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: (() throws -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt() throws
    {
        // <attempt> - Throwable method implementation

        if let error = attemptThrowableError
        {
            throw error
        }

        attemptCallsCount += 1

        // <attempt> - Void return mock implementation

        try attemptClosure?()
    }
}

// MARK: - OBJECTIVE-C
