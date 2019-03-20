import Arguments
import Foundation
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import Terminal
import TerminalMock
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - ImportProtocolMock

open class ImportProtocolMock: ImportProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var testable: Bool
    {
        get { return underlyingTestable }
        set(value) { underlyingTestable = value }
    }

    public var underlyingTestable: Bool = false
}

// MARK: - SourceryBuilderProtocolMock

open class SourceryBuilderProtocolMock: SourceryBuilderProtocol
{
    public init() {}

    public static var executalbeFolderPath: String
    {
        get { return underlyingExecutalbeFolderPath }
        set(value) { underlyingExecutalbeFolderPath = value }
    }

    public static var underlyingExecutalbeFolderPath: String = "AutoMockable filled value"

    // MARK: - <attemptToBuildSourceryIfNeeded> - parameters

    public var attemptToBuildSourceryIfNeededThrowableError: Error?
    public var attemptToBuildSourceryIfNeededCallsCount = 0
    public var attemptToBuildSourceryIfNeededCalled: Bool
    {
        return attemptToBuildSourceryIfNeededCallsCount > 0
    }

    public var attemptToBuildSourceryIfNeededReturnValue: FileProtocol?

    // MARK: - <attemptToBuildSourceryIfNeeded> - closure mocks

    public var attemptToBuildSourceryIfNeededClosure: (() throws -> FileProtocol)?

    // MARK: - <attemptToBuildSourceryIfNeeded> - method mocked

    open func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        // <attemptToBuildSourceryIfNeeded> - Throwable method implementation

        if let error = attemptToBuildSourceryIfNeededThrowableError
        {
            throw error
        }

        attemptToBuildSourceryIfNeededCallsCount += 1

        // <attemptToBuildSourceryIfNeeded> - Return Value mock implementation

        guard let closureReturn = attemptToBuildSourceryIfNeededClosure else
        {
            guard let returnValue = attemptToBuildSourceryIfNeededReturnValue else
            {
                let message = "No returnValue implemented for attemptToBuildSourceryIfNeededClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - SourceryProtocolMock

open class SourceryProtocolMock: ExecutableProtocolMock, SourceryProtocol
{
    public var uuid: String
    {
        get { return underlyingUuid }
        set(value) { underlyingUuid = value }
    }

    public var underlyingUuid: String = "AutoMockable filled value"
    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var templateFolder: FolderProtocol
    {
        get { return underlyingTemplateFolder }
        set(value) { underlyingTemplateFolder = value }
    }

    public var underlyingTemplateFolder: FolderProtocol!
    public var outputFolder: FolderProtocol
    {
        get { return underlyingOutputFolder }
        set(value) { underlyingOutputFolder = value }
    }

    public var underlyingOutputFolder: FolderProtocol!
    public var sourcesFolders: [FolderProtocol] = []
    public var individualSourceFiles: [File]?
    public var sourceryAutoProtocolsFile: FileProtocol
    {
        get { return underlyingSourceryAutoProtocolsFile }
        set(value) { underlyingSourceryAutoProtocolsFile = value }
    }

    public var underlyingSourceryAutoProtocolsFile: FileProtocol!
    public var sourceryYMLFile: FileProtocol
    {
        get { return underlyingSourceryYMLFile }
        set(value) { underlyingSourceryYMLFile = value }
    }

    public var underlyingSourceryYMLFile: FileProtocol!
    public var sourceryExecutableFile: FileProtocol
    {
        get { return underlyingSourceryExecutableFile }
        set(value) { underlyingSourceryExecutableFile = value }
    }

    public var underlyingSourceryExecutableFile: FileProtocol!
    public var imports: Set<TemplatePrepend>
    {
        get { return underlyingImports }
        set(value) { underlyingImports = value }
    }

    public var underlyingImports: Set<TemplatePrepend>!

    // MARK: - <init> - parameters

    public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryExecutableSignPostThrowableError: Error?
    public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryExecutableSignPostReceivedArguments: (productName: String, swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, sourceryExecutable: FileProtocol, signPost: SignPostProtocol)?

    // MARK: - <init> - closure mocks

    public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryExecutableSignPostClosure: ((String, DependencyProtocol, DumpProtocol, FileProtocol, SignPostProtocol) throws -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(productName: String, swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, sourceryExecutable: FileProtocol, signPost: SignPostProtocol) throws
    {
        initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryExecutableSignPostReceivedArguments = (productName: productName, swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, sourceryExecutable: sourceryExecutable, signPost: signPost)
        try? initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryExecutableSignPostClosure?(productName, swiftPackageDependencies, swiftPackageDump, sourceryExecutable, signPost)
    }
}

// MARK: - SourceryWorkerProtocolMock

open class SourceryWorkerProtocolMock: SourceryWorkerProtocol
{
    public init() {}

    public var sourcery: SourceryProtocol
    {
        get { return underlyingSourcery }
        set(value) { underlyingSourcery = value }
    }

    public var underlyingSourcery: SourceryProtocol!

    // MARK: - <init> - parameters

    public var initSourceryTerminalWorkerSignPostQueueThrowableError: Error?
    public var initSourceryTerminalWorkerSignPostQueueReceivedArguments: (sourcery: SourceryProtocol, terminalWorker: TerminalProtocol, signPost: SignPostProtocol, queue: HighwayDispatchProtocol)?

    // MARK: - <init> - closure mocks

    public var initSourceryTerminalWorkerSignPostQueueClosure: ((SourceryProtocol, TerminalProtocol, SignPostProtocol, HighwayDispatchProtocol) throws -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(sourcery: SourceryProtocol, terminalWorker: TerminalProtocol, signPost: SignPostProtocol, queue: HighwayDispatchProtocol) throws
    {
        initSourceryTerminalWorkerSignPostQueueReceivedArguments = (sourcery: sourcery, terminalWorker: terminalWorker, signPost: signPost, queue: queue)
        try? initSourceryTerminalWorkerSignPostQueueClosure?(sourcery, terminalWorker, signPost, queue)
    }

    // MARK: - <executor> - parameters

    public var executorThrowableError: Error?
    public var executorCallsCount = 0
    public var executorCalled: Bool
    {
        return executorCallsCount > 0
    }

    public var executorReturnValue: ArgumentExecutableProtocol?

    // MARK: - <executor> - closure mocks

    public var executorClosure: (() throws -> ArgumentExecutableProtocol)?

    // MARK: - <executor> - method mocked

    open func executor() throws -> ArgumentExecutableProtocol
    {
        // <executor> - Throwable method implementation

        if let error = executorThrowableError
        {
            throw error
        }

        executorCallsCount += 1

        // <executor> - Return Value mock implementation

        guard let closureReturn = executorClosure else
        {
            guard let returnValue = executorReturnValue else
            {
                let message = "No returnValue implemented for executorClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement ArgumentExecutableProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <attempt> - parameters

    public var attemptCallsCount = 0
    public var attemptCalled: Bool
    {
        return attemptCallsCount > 0
    }

    public var attemptReceivedAsyncSourceryWorkerOutput: ((@escaping SourceryWorker.SyncOutput) -> Void)?

    // MARK: - <attempt> - closure mocks

    public var attemptClosure: ((@escaping (@escaping SourceryWorker.SyncOutput) -> Void) -> Void)?

    // MARK: - <attempt> - method mocked

    open func attempt(_ asyncSourceryWorkerOutput: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        attemptCallsCount += 1
        attemptReceivedAsyncSourceryWorkerOutput = asyncSourceryWorkerOutput

        // <attempt> - Void return mock implementation

        attemptClosure?(asyncSourceryWorkerOutput)
    }
}

// MARK: - TemplatePrependProtocolMock

open class TemplatePrependProtocolMock: TemplatePrependProtocol
{
    public init() {}

    public var names: Set<TemplatePrepend.Import>
    {
        get { return underlyingNames }
        set(value) { underlyingNames = value }
    }

    public var underlyingNames: Set<TemplatePrepend.Import>!
    public var template: String
    {
        get { return underlyingTemplate }
        set(value) { underlyingTemplate = value }
    }

    public var underlyingTemplate: String = "AutoMockable filled value"
}

// MARK: - OBJECTIVE-C
