import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - ArgumentsProtocolMock

open class ArgumentsProtocolMock: ArgumentsProtocol
{
    public init() {}

    public var all: [String] = []
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"
}

// MARK: - DependencyProtocolMock

open class DependencyProtocolMock: DependencyProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var path: String
    {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }

    public var underlyingPath: String = "AutoMockable filled value"
    public var url: URL
    {
        get { return underlyingUrl }
        set(value) { underlyingUrl = value }
    }

    public var underlyingUrl: URL!
    public var version: String
    {
        get { return underlyingVersion }
        set(value) { underlyingVersion = value }
    }

    public var underlyingVersion: String = "AutoMockable filled value"
    public var dependencies: [Dependency] = []
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <gitHooks> - parameters

    public var gitHooksThrowableError: Error?
    public var gitHooksCallsCount = 0
    public var gitHooksCalled: Bool
    {
        return gitHooksCallsCount > 0
    }

    public var gitHooksReturnValue: FolderProtocol?

    // MARK: - <gitHooks> - closure mocks

    public var gitHooksClosure: (() throws -> FolderProtocol)?

    // MARK: - <gitHooks> - method mocked

    open func gitHooks() throws -> FolderProtocol
    {
        // <gitHooks> - Throwable method implementation

        if let error = gitHooksThrowableError
        {
            throw error
        }

        gitHooksCallsCount += 1

        // <gitHooks> - Return Value mock implementation

        guard let closureReturn = gitHooksClosure else
        {
            guard let returnValue = gitHooksReturnValue else
            {
                let message = "No returnValue implemented for gitHooksClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <srcRoot> - parameters

    public var srcRootThrowableError: Error?
    public var srcRootCallsCount = 0
    public var srcRootCalled: Bool
    {
        return srcRootCallsCount > 0
    }

    public var srcRootReturnValue: FolderProtocol?

    // MARK: - <srcRoot> - closure mocks

    public var srcRootClosure: (() throws -> FolderProtocol)?

    // MARK: - <srcRoot> - method mocked

    open func srcRoot() throws -> FolderProtocol
    {
        // <srcRoot> - Throwable method implementation

        if let error = srcRootThrowableError
        {
            throw error
        }

        srcRootCallsCount += 1

        // <srcRoot> - Return Value mock implementation

        guard let closureReturn = srcRootClosure else
        {
            guard let returnValue = srcRootReturnValue else
            {
                let message = "No returnValue implemented for srcRootClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <templateFolder> - parameters

    public var templateFolderThrowableError: Error?
    public var templateFolderCallsCount = 0
    public var templateFolderCalled: Bool
    {
        return templateFolderCallsCount > 0
    }

    public var templateFolderReturnValue: FolderProtocol?

    // MARK: - <templateFolder> - closure mocks

    public var templateFolderClosure: (() throws -> FolderProtocol)?

    // MARK: - <templateFolder> - method mocked

    open func templateFolder() throws -> FolderProtocol
    {
        // <templateFolder> - Throwable method implementation

        if let error = templateFolderThrowableError
        {
            throw error
        }

        templateFolderCallsCount += 1

        // <templateFolder> - Return Value mock implementation

        guard let closureReturn = templateFolderClosure else
        {
            guard let returnValue = templateFolderReturnValue else
            {
                let message = "No returnValue implemented for templateFolderClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <sourceryFolder> - parameters

    public var sourceryFolderThrowableError: Error?
    public var sourceryFolderCallsCount = 0
    public var sourceryFolderCalled: Bool
    {
        return sourceryFolderCallsCount > 0
    }

    public var sourceryFolderReturnValue: FolderProtocol?

    // MARK: - <sourceryFolder> - closure mocks

    public var sourceryFolderClosure: (() throws -> FolderProtocol)?

    // MARK: - <sourceryFolder> - method mocked

    open func sourceryFolder() throws -> FolderProtocol
    {
        // <sourceryFolder> - Throwable method implementation

        if let error = sourceryFolderThrowableError
        {
            throw error
        }

        sourceryFolderCallsCount += 1

        // <sourceryFolder> - Return Value mock implementation

        guard let closureReturn = sourceryFolderClosure else
        {
            guard let returnValue = sourceryFolderReturnValue else
            {
                let message = "No returnValue implemented for sourceryFolderClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <sourceryAutoProtocolFile> - parameters

    public var sourceryAutoProtocolFileThrowableError: Error?
    public var sourceryAutoProtocolFileCallsCount = 0
    public var sourceryAutoProtocolFileCalled: Bool
    {
        return sourceryAutoProtocolFileCallsCount > 0
    }

    public var sourceryAutoProtocolFileReturnValue: FileProtocol?

    // MARK: - <sourceryAutoProtocolFile> - closure mocks

    public var sourceryAutoProtocolFileClosure: (() throws -> FileProtocol)?

    // MARK: - <sourceryAutoProtocolFile> - method mocked

    open func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        // <sourceryAutoProtocolFile> - Throwable method implementation

        if let error = sourceryAutoProtocolFileThrowableError
        {
            throw error
        }

        sourceryAutoProtocolFileCallsCount += 1

        // <sourceryAutoProtocolFile> - Return Value mock implementation

        guard let closureReturn = sourceryAutoProtocolFileClosure else
        {
            guard let returnValue = sourceryAutoProtocolFileReturnValue else
            {
                let message = "No returnValue implemented for sourceryAutoProtocolFileClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - DumpProtocolMock

open class DumpProtocolMock: DumpProtocol
{
    public init() {}

    public var products: Set<SwiftProduct>
    {
        get { return underlyingProducts }
        set(value) { underlyingProducts = value }
    }

    public var underlyingProducts: Set<SwiftProduct>!
    public var targets: Set<SwiftTarget>
    {
        get { return underlyingTargets }
        set(value) { underlyingTargets = value }
    }

    public var underlyingTargets: Set<SwiftTarget>!
}

// MARK: - SwiftProductProtocolMock

open class SwiftProductProtocolMock: SwiftProductProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var product_type: String
    {
        get { return underlyingProduct_type }
        set(value) { underlyingProduct_type = value }
    }

    public var underlyingProduct_type: String = "AutoMockable filled value"
}

// MARK: - SwiftTargetProtocolMock

open class SwiftTargetProtocolMock: SwiftTargetProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var dependencies: Set<SwiftTarget.Dependency>
    {
        get { return underlyingDependencies }
        set(value) { underlyingDependencies = value }
    }

    public var underlyingDependencies: Set<SwiftTarget.Dependency>!
}

// MARK: - OBJECTIVE-C
