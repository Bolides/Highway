import Arguments
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

    public static var shared: DocumentationWorkerProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: DocumentationWorkerProtocol!

    // MARK: - <attemptJazzyDocs> - parameters

    public var attemptJazzyDocsInPackageNameForThrowableError: Error?
    public var attemptJazzyDocsInPackageNameForCallsCount = 0
    public var attemptJazzyDocsInPackageNameForCalled: Bool
    {
        return attemptJazzyDocsInPackageNameForCallsCount > 0
    }

    public var attemptJazzyDocsInPackageNameForReceivedArguments: (folder: FolderProtocol, packageName: String, products: Set<SwiftProduct>)?
    public var attemptJazzyDocsInPackageNameForReturnValue: [String]?

    // MARK: - <attemptJazzyDocs> - closure mocks

    public var attemptJazzyDocsInPackageNameForClosure: ((FolderProtocol, String, Set<SwiftProduct>) throws -> [String])?

    // MARK: - <attemptJazzyDocs> - method mocked

    open func attemptJazzyDocs(in folder: FolderProtocol, packageName: String, for products: Set<SwiftProduct>) throws -> [String]
    {
        // <attemptJazzyDocs> - Throwable method implementation

        if let error = attemptJazzyDocsInPackageNameForThrowableError
        {
            throw error
        }

        attemptJazzyDocsInPackageNameForCallsCount += 1
        attemptJazzyDocsInPackageNameForReceivedArguments = (folder: folder, packageName: packageName, products: products)

        // <attemptJazzyDocs> - Return Value mock implementation

        guard let closureReturn = attemptJazzyDocsInPackageNameForClosure else
        {
            guard let returnValue = attemptJazzyDocsInPackageNameForReturnValue else
            {
                let message = "No returnValue implemented for attemptJazzyDocsInPackageNameForClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(folder, packageName, products)
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
