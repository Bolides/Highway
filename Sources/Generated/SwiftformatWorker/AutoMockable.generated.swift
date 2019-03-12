import Foundation
import HighwayDispatch
import SourceryAutoProtocols
import SwiftFormatWorker
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - SwiftFormatWorkerProtocolMock

open class SwiftFormatWorkerProtocolMock: SwiftFormatWorkerProtocol
{
    public init() {}

    public var queue: HighwayDispatchProtocol
    {
        get { return underlyingQueue }
        set(value) { underlyingQueue = value }
    }

    public var underlyingQueue: HighwayDispatchProtocol!

    // MARK: - <init> - parameters

    public var initFolderToFormatRecursiveQueueSignPostThrowableError: Error?
    public var initFolderToFormatRecursiveQueueSignPostReceivedArguments: (folderToFormatRecursive: FolderProtocol, queue: HighwayDispatchProtocol, signPost: SignPostProtocol)?

    // MARK: - <init> - closure mocks

    public var initFolderToFormatRecursiveQueueSignPostClosure: ((FolderProtocol, HighwayDispatchProtocol, SignPostProtocol) throws -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(folderToFormatRecursive: FolderProtocol, queue: HighwayDispatchProtocol, signPost: SignPostProtocol) throws
    {
        initFolderToFormatRecursiveQueueSignPostReceivedArguments = (folderToFormatRecursive: folderToFormatRecursive, queue: queue, signPost: signPost)
        try? initFolderToFormatRecursiveQueueSignPostClosure?(folderToFormatRecursive, queue, signPost)
    }

    // MARK: - <attempt> - parameters

    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReceivedAsyncSwiftFormatAttemptOutput: ((@escaping SwiftFormatWorker.SyncOutput) -> Void)?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: ((@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void) -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt(_ asyncSwiftFormatAttemptOutput: @escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void)
    {
        attemptCallsCount += 1
        attemptReceivedAsyncSwiftFormatAttemptOutput = asyncSwiftFormatAttemptOutput

        // <attempt> - Void return mock implementation

        attemptClosure?(asyncSwiftFormatAttemptOutput)
    }
}

// MARK: - OBJECTIVE-C
