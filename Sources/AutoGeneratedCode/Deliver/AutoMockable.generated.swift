import Deliver
import Foundation
import os
import SourceryAutoProtocols
import ZFile
import ZFileMock

// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - DeliverProtocolMock

open class DeliverProtocolMock: DeliverProtocol
{
    public init() {}

    // MARK: - <now> - parameters

    public var nowWithThrowableError: Error?
    public var nowWithCallsCount = 0
    public var nowWithCalled: Bool
    {
        return nowWithCallsCount > 0
    }

    public var nowWithReceivedOptions: Deliver.Options?
    public var nowWithReturnValue: Bool?

    // MARK: - <now> - closure mocks

    public var nowWithClosure: ((Deliver.Options) throws -> Bool)?

    // MARK: - <now> - method mocked

    open func now(with options: Deliver.Options) throws -> Bool
    {
        // <now> - Throwable method implementation

        if let error = nowWithThrowableError
        {
            throw error
        }

        nowWithCallsCount += 1
        nowWithReceivedOptions = options

        // <now> - Return Value mock implementation

        guard let closureReturn = nowWithClosure else
        {
            guard let returnValue = nowWithReturnValue else
            {
                let message = "No returnValue implemented for nowWithClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)
                throw error
            }
            return returnValue
        }

        return try closureReturn(options)
    }
}

// MARK: - JWTTokenWorkerProtocolMock

open class JWTTokenWorkerProtocolMock: JWTTokenWorkerProtocol
{
    public init() {}

    public var token: String
    {
        get { return underlyingToken }
        set(value) { underlyingToken = value }
    }

    public var underlyingToken: String = "AutoMockable filled value"
}

// MARK: - OBJECTIVE-C
