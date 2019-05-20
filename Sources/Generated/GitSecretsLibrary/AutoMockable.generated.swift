import Errors
import Foundation
import GitSecretsLibrary
import Highway
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - GitSecretWorkerProtocolMock

open class GitSecretWorkerProtocolMock: GitSecretWorkerProtocol
{
    public init() {}

    // MARK: - <attemptHideSecrets> - parameters

    public var attemptHideSecretsInThrowableError: Error?
    public var attemptHideSecretsInCallsCount = 0
    public var attemptHideSecretsInCalled: Bool
    {
        return attemptHideSecretsInCallsCount > 0
    }

    public var attemptHideSecretsInReceivedFolder: FolderProtocol?

    // MARK: - <attemptHideSecrets> - closure mocks

    public var attemptHideSecretsInClosure: ((FolderProtocol) throws -> Void)?

    // MARK: - <attemptHideSecrets> - method mocked

    open func attemptHideSecrets(in folder: FolderProtocol) throws
    {
        // <attemptHideSecrets> - Throwable method implementation

        if let error = attemptHideSecretsInThrowableError
        {
            throw error
        }

        attemptHideSecretsInCallsCount += 1
        attemptHideSecretsInReceivedFolder = folder

        // <attemptHideSecrets> - Void return mock implementation

        try attemptHideSecretsInClosure?(folder)
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
