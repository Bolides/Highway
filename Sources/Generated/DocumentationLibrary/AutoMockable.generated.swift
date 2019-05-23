import DocumentationLibrary
import Errors
import Foundation
import Highway
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

    public var attemptJazzyDocsInForThrowableError: Error?
    public var attemptJazzyDocsInForCallsCount = 0
    public var attemptJazzyDocsInForCalled: Bool
    {
        return attemptJazzyDocsInForCallsCount > 0
    }

    public var attemptJazzyDocsInForReceivedArguments: (folder: FolderProtocol, dump: DumpProtocol)?
    public var attemptJazzyDocsInForReturnValue: [String]?

    // MARK: - <attemptJazzyDocs> - closure mocks

    public var attemptJazzyDocsInForClosure: ((FolderProtocol, DumpProtocol) throws -> [String])?

    // MARK: - <attemptJazzyDocs> - method mocked

    open func attemptJazzyDocs(in folder: FolderProtocol, for dump: DumpProtocol) throws -> [String]
    {
        // <attemptJazzyDocs> - Throwable method implementation

        if let error = attemptJazzyDocsInForThrowableError
        {
            throw error
        }

        attemptJazzyDocsInForCallsCount += 1
        attemptJazzyDocsInForReceivedArguments = (folder: folder, dump: dump)

        // <attemptJazzyDocs> - Return Value mock implementation

        guard let closureReturn = attemptJazzyDocsInForClosure else
        {
            guard let returnValue = attemptJazzyDocsInForReturnValue else
            {
                let message = "No returnValue implemented for attemptJazzyDocsInForClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(folder, dump)
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
