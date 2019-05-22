import DocumentationLibrary
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - DocumentationWorkerProtocolMock

open class DocumentationWorkerProtocolMock: DocumentationWorkerProtocol
{
    public init() {}

    // MARK: - <attemptJazzyDocs> - parameters

    public var attemptJazzyDocsInThrowableError: Error?
    public var attemptJazzyDocsInCallsCount = 0
    public var attemptJazzyDocsInCalled: Bool
    {
        return attemptJazzyDocsInCallsCount > 0
    }

    public var attemptJazzyDocsInReceivedFolder: FolderProtocol?
    public var attemptJazzyDocsInReturnValue: [String]?

    // MARK: - <attemptJazzyDocs> - closure mocks

    public var attemptJazzyDocsInClosure: ((FolderProtocol) throws -> [String])?

    // MARK: - <attemptJazzyDocs> - method mocked

    open func attemptJazzyDocs(in folder: FolderProtocol) throws -> [String]
    {
        // <attemptJazzyDocs> - Throwable method implementation

        if let error = attemptJazzyDocsInThrowableError
        {
            throw error
        }

        attemptJazzyDocsInCallsCount += 1
        attemptJazzyDocsInReceivedFolder = folder

        // <attemptJazzyDocs> - Return Value mock implementation

        guard let closureReturn = attemptJazzyDocsInClosure else
        {
            guard let returnValue = attemptJazzyDocsInReturnValue else
            {
                let message = "No returnValue implemented for attemptJazzyDocsInClosure"
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
