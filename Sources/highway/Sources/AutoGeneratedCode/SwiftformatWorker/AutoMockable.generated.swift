import Foundation
import os
import SourceryAutoProtocols
import SwiftFormatWorker
import ZFile
import ZFileMock

// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - SwiftFormatWorkerProtocolMock

open class SwiftFormatWorkerProtocolMock: SwiftFormatWorkerProtocol
{
    public init() {}

    // MARK: - <attempt> - parameters

    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }
    public var attemptReceivedAsync: ((@escaping SwiftFormatWorker.SyncOutput) -> Void)?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: (((@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void)) -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt(_ async: (@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void))
    {
        attemptCallsCount += 1
        attemptReceivedAsync = async

        // <attempt> - Void return mock implementation

        attemptClosure?(async)
    }
}

// MARK: - OBJECTIVE-C
