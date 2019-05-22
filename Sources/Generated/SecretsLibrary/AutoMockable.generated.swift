import Errors
import Foundation
import HighwayDispatch
import SecretsLibrary
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - SecretProtocolMock

open class SecretProtocolMock: SecretProtocol
{
    public init() {}

    public var gpgPassphrase: String
    {
        get { return underlyingGpgPassphrase }
        set(value) { underlyingGpgPassphrase = value }
    }

    public var underlyingGpgPassphrase: String = "AutoMockable filled value"
}

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
    public static var gitSecretname: String
    {
        get { return underlyingGitSecretname }
        set(value) { underlyingGitSecretname = value }
    }

    public static var underlyingGitSecretname: String = "AutoMockable filled value"

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

    // MARK: - <attemptHideSecretsWithgpg> - parameters

    public var attemptHideSecretsWithgpgInThrowableError: Error?
    public var attemptHideSecretsWithgpgInCallsCount = 0
    public var attemptHideSecretsWithgpgInCalled: Bool
    {
        return attemptHideSecretsWithgpgInCallsCount > 0
    }

    public var attemptHideSecretsWithgpgInReceivedFolder: FolderProtocol?
    public var attemptHideSecretsWithgpgInReturnValue: [String]?

    // MARK: - <attemptHideSecretsWithgpg> - closure mocks

    public var attemptHideSecretsWithgpgInClosure: ((FolderProtocol) throws -> [String])?

    // MARK: - <attemptHideSecretsWithgpg> - method mocked

    open func attemptHideSecretsWithgpg(in folder: FolderProtocol) throws -> [String]
    {
        // <attemptHideSecretsWithgpg> - Throwable method implementation

        if let error = attemptHideSecretsWithgpgInThrowableError
        {
            throw error
        }

        attemptHideSecretsWithgpgInCallsCount += 1
        attemptHideSecretsWithgpgInReceivedFolder = folder

        // <attemptHideSecretsWithgpg> - Return Value mock implementation

        guard let closureReturn = attemptHideSecretsWithgpgInClosure else
        {
            guard let returnValue = attemptHideSecretsWithgpgInReturnValue else
            {
                let message = "No returnValue implemented for attemptHideSecretsWithgpgInClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(folder)
    }

    // MARK: - <gitSecretProcess> - parameters

    public var gitSecretProcessInThrowableError: Error?
    public var gitSecretProcessInCallsCount = 0
    public var gitSecretProcessInCalled: Bool
    {
        return gitSecretProcessInCallsCount > 0
    }

    public var gitSecretProcessInReceivedFolder: FolderProtocol?
    public var gitSecretProcessInReturnValue: ProcessProtocol?

    // MARK: - <gitSecretProcess> - closure mocks

    public var gitSecretProcessInClosure: ((FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <gitSecretProcess> - method mocked

    open func gitSecretProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <gitSecretProcess> - Throwable method implementation

        if let error = gitSecretProcessInThrowableError
        {
            throw error
        }

        gitSecretProcessInCallsCount += 1
        gitSecretProcessInReceivedFolder = folder

        // <gitSecretProcess> - Return Value mock implementation

        guard let closureReturn = gitSecretProcessInClosure else
        {
            guard let returnValue = gitSecretProcessInReturnValue else
            {
                let message = "No returnValue implemented for gitSecretProcessInClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement ProcessProtocol

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
