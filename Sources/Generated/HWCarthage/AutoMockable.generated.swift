import Errors
import Foundation
import HighwayDispatch
import HWCarthage
import SignPost
import SourceryAutoProtocols
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - CarthageBuilderProtocolMock

open class CarthageBuilderProtocolMock: CarthageBuilderProtocol
{
    public init() {}

    // MARK: - <attempt> - parameters

    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReceivedAsync: ((@escaping CarthageBuilder.SyncOutput) -> Void)?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: ((@escaping (@escaping CarthageBuilder.SyncOutput) -> Void) -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt(_ async: @escaping (@escaping CarthageBuilder.SyncOutput) -> Void)
    {
        attemptCallsCount += 1
        attemptReceivedAsync = async

        // <attempt> - Void return mock implementation

        attemptClosure?(async)
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

    // MARK: - <attempt> - parameters

    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReceivedAsync: ((@escaping HWCarthage.SyncOutput) -> Void)?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: ((@escaping (@escaping HWCarthage.SyncOutput) -> Void) -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt(_ async: @escaping (@escaping HWCarthage.SyncOutput) -> Void)
    {
        attemptCallsCount += 1
        attemptReceivedAsync = async

        // <attempt> - Void return mock implementation

        attemptClosure?(async)
    }
}

// MARK: - OBJECTIVE-C
