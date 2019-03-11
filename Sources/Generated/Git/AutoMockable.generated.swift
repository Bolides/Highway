

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - GitToolProtocolMock

open class GitToolProtocolMock: GitToolProtocol
{
    public init() {}

    // MARK: - <addAll> - parameters

    public var addAllThrowableError: Error?
    public var addAllCallsCount = 0
    public var addAllCalled: Bool
    {
        return addAllCallsCount > 0
    }

    // MARK: - <addAll> - closure mocks

    public var addAllClosure: (() throws -> Void)?

    // MARK: - <addAll> - method mocked

    open func addAll() throws
    {
        // <addAll> - Throwable method implementation

        if let error = addAllThrowableError
        {
            throw error
        }

        addAllCallsCount += 1

        // <addAll> - Void return mock implementation

        try addAllClosure?()
    }

    // MARK: - <commit> - parameters

    public var commitMessageThrowableError: Error?
    public var commitMessageCallsCount = 0
    public var commitMessageCalled: Bool
    {
        return commitMessageCallsCount > 0
    }

    public var commitMessageReceivedMessage: String?

    // MARK: - <commit> - closure mocks

    public var commitMessageClosure: ((String) throws -> Void)?

    // MARK: - <commit> - method mocked

    open func commit(message: String) throws
    {
        // <commit> - Throwable method implementation

        if let error = commitMessageThrowableError
        {
            throw error
        }

        commitMessageCallsCount += 1
        commitMessageReceivedMessage = message

        // <commit> - Void return mock implementation

        try commitMessageClosure?(message)
    }

    // MARK: - <pushToMaster> - parameters

    public var pushToMasterThrowableError: Error?
    public var pushToMasterCallsCount = 0
    public var pushToMasterCalled: Bool
    {
        return pushToMasterCallsCount > 0
    }

    // MARK: - <pushToMaster> - closure mocks

    public var pushToMasterClosure: (() throws -> Void)?

    // MARK: - <pushToMaster> - method mocked

    open func pushToMaster() throws
    {
        // <pushToMaster> - Throwable method implementation

        if let error = pushToMasterThrowableError
        {
            throw error
        }

        pushToMasterCallsCount += 1

        // <pushToMaster> - Void return mock implementation

        try pushToMasterClosure?()
    }

    // MARK: - <pushTagsToMaster> - parameters

    public var pushTagsToMasterThrowableError: Error?
    public var pushTagsToMasterCallsCount = 0
    public var pushTagsToMasterCalled: Bool
    {
        return pushTagsToMasterCallsCount > 0
    }

    // MARK: - <pushTagsToMaster> - closure mocks

    public var pushTagsToMasterClosure: (() throws -> Void)?

    // MARK: - <pushTagsToMaster> - method mocked

    open func pushTagsToMaster() throws
    {
        // <pushTagsToMaster> - Throwable method implementation

        if let error = pushTagsToMasterThrowableError
        {
            throw error
        }

        pushTagsToMasterCallsCount += 1

        // <pushTagsToMaster> - Void return mock implementation

        try pushTagsToMasterClosure?()
    }

    // MARK: - <pull> - parameters

    public var pullThrowableError: Error?
    public var pullCallsCount = 0
    public var pullCalled: Bool
    {
        return pullCallsCount > 0
    }

    // MARK: - <pull> - closure mocks

    public var pullClosure: (() throws -> Void)?

    // MARK: - <pull> - method mocked

    open func pull() throws
    {
        // <pull> - Throwable method implementation

        if let error = pullThrowableError
        {
            throw error
        }

        pullCallsCount += 1

        // <pull> - Void return mock implementation

        try pullClosure?()
    }

    // MARK: - <currentTag> - parameters

    public var currentTagThrowableError: Error?
    public var currentTagCallsCount = 0
    public var currentTagCalled: Bool
    {
        return currentTagCallsCount > 0
    }

    public var currentTagReturnValue: [String]?

    // MARK: - <currentTag> - closure mocks

    public var currentTagClosure: (() throws -> [String])?

    // MARK: - <currentTag> - method mocked

    open func currentTag() throws -> [String]
    {
        // <currentTag> - Throwable method implementation

        if let error = currentTagThrowableError
        {
            throw error
        }

        currentTagCallsCount += 1

        // <currentTag> - Return Value mock implementation

        guard let closureReturn = currentTagClosure else
        {
            guard let returnValue = currentTagReturnValue else
            {
                let message = "No returnValue implemented for currentTagClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <clone> - parameters

    public var cloneWithThrowableError: Error?
    public var cloneWithCallsCount = 0
    public var cloneWithCalled: Bool
    {
        return cloneWithCallsCount > 0
    }

    public var cloneWithReceivedOptions: CloneOptions?
    public var cloneWithReturnValue: [String]?

    // MARK: - <clone> - closure mocks

    public var cloneWithClosure: ((CloneOptions) throws -> [String])?

    // MARK: - <clone> - method mocked

    open func clone(with options: CloneOptions) throws -> [String]
    {
        // <clone> - Throwable method implementation

        if let error = cloneWithThrowableError
        {
            throw error
        }

        cloneWithCallsCount += 1
        cloneWithReceivedOptions = options

        // <clone> - Return Value mock implementation

        guard let closureReturn = cloneWithClosure else
        {
            guard let returnValue = cloneWithReturnValue else
            {
                let message = "No returnValue implemented for cloneWithClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(options)
    }
}

// MARK: - OBJECTIVE-C
