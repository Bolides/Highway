import Errors
import Foundation
import HighwayDispatch
import HWPod
import SignPost
import SourceryAutoProtocols
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - HWPodProtocolMock

open class HWPodProtocolMock: HWPodProtocol
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
