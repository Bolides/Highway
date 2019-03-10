import Foundation
import HighwayDispatch
import os
import SourceryAutoProtocols
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - HighwayDispatchProtocolMock

open class HighwayDispatchProtocolMock: HighwayDispatchProtocol
{
    public init() {}

    // MARK: - <async> - parameters

    public var asyncSyncCallsCount = 0
    public var asyncSyncCalled: Bool
    {
        return asyncSyncCallsCount > 0
    }

    public var asyncSyncReceivedSync: (() -> Void)?

    // MARK: - <async> - closure mocks

    public var asyncSyncClosure: ((@escaping () -> Void) -> Void)?

    // MARK: - <async> - method mocked

    open func async(sync: @escaping () -> Void)
    {
        asyncSyncCallsCount += 1
        asyncSyncReceivedSync = sync

        // <async> - Void return mock implementation

        asyncSyncClosure?(sync)
    }
}

// MARK: - OBJECTIVE-C
