import Errors
import Foundation
import GitSecretsLibrary
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - SecretsWorkerProtocolMock

open class SecretsWorkerProtocolMock: SecretsWorkerProtocol
{
    public init() {}

    public static var shared: SecretsWorker
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: SecretsWorker!

    // MARK: - <attemptHideSecrets> - parameters

    public var attemptHideSecretsInThrowableError: Error?
    public var attemptHideSecretsInCallsCount = 0
    public var attemptHideSecretsInCalled: Bool
    {
        return attemptHideSecretsInCallsCount > 0
    }

    public var attemptHideSecretsInReceivedFolder: FolderProtocol?
    public var attemptHideSecretsInReturnValue: [String]?

    // MARK: - <attemptHideSecrets> - closure mocks

    public var attemptHideSecretsInClosure: ((FolderProtocol) throws -> [String])?

    // MARK: - <attemptHideSecrets> - method mocked

    open func attemptHideSecrets(in folder: FolderProtocol) throws -> [String]
    {
        // <attemptHideSecrets> - Throwable method implementation

        if let error = attemptHideSecretsInThrowableError
        {
            throw error
        }

        attemptHideSecretsInCallsCount += 1
        attemptHideSecretsInReceivedFolder = folder

        // <attemptHideSecrets> - Return Value mock implementation

        guard let closureReturn = attemptHideSecretsInClosure else
        {
            guard let returnValue = attemptHideSecretsInReturnValue else
            {
                let message = "No returnValue implemented for attemptHideSecretsInClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(folder)
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
