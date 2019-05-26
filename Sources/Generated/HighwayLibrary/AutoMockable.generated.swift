import DocumentationLibrary
import Errors
import Foundation
import GitHooks
import HighwayDispatch
import HighwayLibrary
import SecretsLibrary
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - HighwayProtocolMock

open class HighwayProtocolMock: HighwayProtocol
{
    public init() {}

    public static var queue: HighwayDispatchProtocol
    {
        get { return underlyingQueue }
        set(value) { underlyingQueue = value }
    }

    public static var underlyingQueue: HighwayDispatchProtocol!
    public var package: PackageProtocol
    {
        get { return underlyingPackage }
        set(value) { underlyingPackage = value }
    }

    public var underlyingPackage: PackageProtocol!
    public var sourceryBuilder: SourceryBuilderProtocol?
    public var sourceryWorkers: [SourceryWorkerProtocol]?
    public var queue: HighwayDispatchProtocol
    {
        get { return underlyingQueue }
        set(value) { underlyingQueue = value }
    }

    public var underlyingQueue: HighwayDispatchProtocol!
    public var githooks: GitHooksWorkerProtocol?
    public var swiftformat: SwiftFormatWorkerProtocol
    {
        get { return underlyingSwiftformat }
        set(value) { underlyingSwiftformat = value }
    }

    public var underlyingSwiftformat: SwiftFormatWorkerProtocol!
    public static var xcodeConfigOverride: [String] = []
    public static var swiftCFlags: [String] = []
    public var highwaySetupExecutableName: String?

    // MARK: - <dependency> - parameters

    public var dependencyWithThrowableError: Error?
    public var dependencyWithCallsCount = 0
    public var dependencyWithCalled: Bool
    {
        return dependencyWithCallsCount > 0
    }

    public var dependencyWithReceivedName: String?
    public var dependencyWithReturnValue: DependencyProtocol?

    // MARK: - <dependency> - closure mocks

    public var dependencyWithClosure: ((String) throws -> DependencyProtocol)?

    // MARK: - <dependency> - method mocked

    open func dependency(with name: String) throws -> DependencyProtocol
    {
        // <dependency> - Throwable method implementation

        if let error = dependencyWithThrowableError
        {
            throw error
        }

        dependencyWithCallsCount += 1
        dependencyWithReceivedName = name

        // <dependency> - Return Value mock implementation

        guard let closureReturn = dependencyWithClosure else
        {
            guard let returnValue = dependencyWithReturnValue else
            {
                let message = "No returnValue implemented for dependencyWithClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement DependencyProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(name)
    }

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

    // MARK: - <templateFolder> - parameters

    public var templateFolderExpectedNameThrowableError: Error?
    public var templateFolderExpectedNameCallsCount = 0
    public var templateFolderExpectedNameCalled: Bool
    {
        return templateFolderExpectedNameCallsCount > 0
    }

    public var templateFolderExpectedNameReceivedExpectedName: String?
    public var templateFolderExpectedNameReturnValue: FolderProtocol?

    // MARK: - <templateFolder> - closure mocks

    public var templateFolderExpectedNameClosure: ((String) throws -> FolderProtocol)?

    // MARK: - <templateFolder> - method mocked

    open func templateFolder(expectedName: String) throws -> FolderProtocol
    {
        // <templateFolder> - Throwable method implementation

        if let error = templateFolderExpectedNameThrowableError
        {
            throw error
        }

        templateFolderExpectedNameCallsCount += 1
        templateFolderExpectedNameReceivedExpectedName = expectedName

        // <templateFolder> - Return Value mock implementation

        guard let closureReturn = templateFolderExpectedNameClosure else
        {
            guard let returnValue = templateFolderExpectedNameReturnValue else
            {
                let message = "No returnValue implemented for templateFolderExpectedNameClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(expectedName)
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

    // MARK: - <package> - parameters

    public static var packageForDependencyServiceDumpServiceTerminalSignPostThrowableError: Error?
    public static var packageForDependencyServiceDumpServiceTerminalSignPostCallsCount = 0
    public static var packageForDependencyServiceDumpServiceTerminalSignPostCalled: Bool
    {
        return packageForDependencyServiceDumpServiceTerminalSignPostCallsCount > 0
    }

    public static var packageForDependencyServiceDumpServiceTerminalSignPostReceivedArguments: (folder: FolderProtocol, dependencyService: DependencyServiceProtocol, dumpService: DumpService, terminal: TerminalProtocol, signPost: SignPostProtocol)?
    public static var packageForDependencyServiceDumpServiceTerminalSignPostReturnValue: PackageProtocol?

    // MARK: - <package> - closure mocks

    public static var packageForDependencyServiceDumpServiceTerminalSignPostClosure: ((FolderProtocol, DependencyServiceProtocol, DumpService, TerminalProtocol, SignPostProtocol) throws -> PackageProtocol)?

    // MARK: - <package> - method mocked

    public static func package(for folder: FolderProtocol, dependencyService: DependencyServiceProtocol, dumpService: DumpService, terminal: TerminalProtocol, signPost: SignPostProtocol) throws -> PackageProtocol
    {
        // <package> - Throwable method implementation

        if let error = packageForDependencyServiceDumpServiceTerminalSignPostThrowableError
        {
            throw error
        }

        packageForDependencyServiceDumpServiceTerminalSignPostCallsCount += 1
        packageForDependencyServiceDumpServiceTerminalSignPostReceivedArguments = (folder: folder, dependencyService: dependencyService, dumpService: dumpService, terminal: terminal, signPost: signPost)

        // <package> - Return Value mock implementation

        guard let closureReturn = packageForDependencyServiceDumpServiceTerminalSignPostClosure else
        {
            guard let returnValue = packageForDependencyServiceDumpServiceTerminalSignPostReturnValue else
            {
                let message = "No returnValue implemented for packageForDependencyServiceDumpServiceTerminalSignPostClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement PackageProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(folder, dependencyService, dumpService, terminal, signPost)
    }
}

// MARK: - HighwayRunnerProtocolMock

open class HighwayRunnerProtocolMock: HighwayRunnerProtocol
{
    public init() {}

    public static var queue: HighwayDispatchProtocol
    {
        get { return underlyingQueue }
        set(value) { underlyingQueue = value }
    }

    public static var underlyingQueue: HighwayDispatchProtocol!
    public var errors: [Swift.Error]?
    public var highway: HighwayProtocol
    {
        get { return underlyingHighway }
        set(value) { underlyingHighway = value }
    }

    public var underlyingHighway: HighwayProtocol!

    // MARK: - <generateDocs> - parameters

    public var generateDocsForPackageNameCallsCount = 0
    public var generateDocsForPackageNameCalled: Bool
    {
        return generateDocsForPackageNameCallsCount > 0
    }

    public var generateDocsForPackageNameReceivedArguments: (products: Set<SwiftProduct>, packageName: String, async: (@escaping HighwayRunner.SyncDocs) -> Void)?

    // MARK: - <generateDocs> - closure mocks

    public var generateDocsForPackageNameClosure: ((Set<SwiftProduct>, String, @escaping (@escaping HighwayRunner.SyncDocs) -> Void) -> Void)?

    // MARK: - <generateDocs> - method mocked

    open func generateDocs(for products: Set<SwiftProduct>, packageName: String, _ async: @escaping (@escaping HighwayRunner.SyncDocs) -> Void)
    {
        generateDocsForPackageNameCallsCount += 1
        generateDocsForPackageNameReceivedArguments = (products: products, packageName: packageName, async: async)

        // <generateDocs> - Void return mock implementation

        generateDocsForPackageNameClosure?(products, packageName, async)
    }

    // MARK: - <runTests> - parameters

    public var runTestsCallsCount = 0
    public var runTestsCalled: Bool
    {
        return runTestsCallsCount > 0
    }

    public var runTestsReceivedAsync: ((@escaping HighwayRunner.SyncTestOutput) -> Void)?

    // MARK: - <runTests> - closure mocks

    public var runTestsClosure: ((@escaping (@escaping HighwayRunner.SyncTestOutput) -> Void) -> Void)?

    // MARK: - <runTests> - method mocked

    open func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    {
        runTestsCallsCount += 1
        runTestsReceivedAsync = async

        // <runTests> - Void return mock implementation

        runTestsClosure?(async)
    }

    // MARK: - <runSourcery> - parameters

    public var runSourceryCallsCount = 0
    public var runSourceryCalled: Bool
    {
        return runSourceryCallsCount > 0
    }

    public var runSourceryReceivedAsync: ((@escaping SourceryWorker.SyncOutput) -> Void)?

    // MARK: - <runSourcery> - closure mocks

    public var runSourceryClosure: ((@escaping (@escaping SourceryWorker.SyncOutput) -> Void) -> Void)?

    // MARK: - <runSourcery> - method mocked

    open func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        runSourceryCallsCount += 1
        runSourceryReceivedAsync = async

        // <runSourcery> - Void return mock implementation

        runSourceryClosure?(async)
    }

    // MARK: - <addGithooksPrePush> - parameters

    public var addGithooksPrePushThrowableError: Error?
    public var addGithooksPrePushCallsCount = 0
    public var addGithooksPrePushCalled: Bool
    {
        return addGithooksPrePushCallsCount > 0
    }

    // MARK: - <addGithooksPrePush> - closure mocks

    public var addGithooksPrePushClosure: (() throws -> Void)?

    // MARK: - <addGithooksPrePush> - method mocked

    open func addGithooksPrePush() throws
    {
        // <addGithooksPrePush> - Throwable method implementation

        if let error = addGithooksPrePushThrowableError
        {
            throw error
        }

        addGithooksPrePushCallsCount += 1

        // <addGithooksPrePush> - Void return mock implementation

        try addGithooksPrePushClosure?()
    }

    // MARK: - <runSwiftformat> - parameters

    public var runSwiftformatCallsCount = 0
    public var runSwiftformatCalled: Bool
    {
        return runSwiftformatCallsCount > 0
    }

    public var runSwiftformatReceivedAsync: ((@escaping HighwayRunner.SyncSwiftformat) -> Void)?

    // MARK: - <runSwiftformat> - closure mocks

    public var runSwiftformatClosure: ((@escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void) -> Void)?

    // MARK: - <runSwiftformat> - method mocked

    open func runSwiftformat(_ async: @escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void)
    {
        runSwiftformatCallsCount += 1
        runSwiftformatReceivedAsync = async

        // <runSwiftformat> - Void return mock implementation

        runSwiftformatClosure?(async)
    }

    // MARK: - <runSwiftPackageGenerateXcodeProject> - parameters

    public var runSwiftPackageGenerateXcodeProjectCallsCount = 0
    public var runSwiftPackageGenerateXcodeProjectCalled: Bool
    {
        return runSwiftPackageGenerateXcodeProjectCallsCount > 0
    }

    public var runSwiftPackageGenerateXcodeProjectReceivedAsync: ((@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)?

    // MARK: - <runSwiftPackageGenerateXcodeProject> - closure mocks

    public var runSwiftPackageGenerateXcodeProjectClosure: ((@escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void) -> Void)?

    // MARK: - <runSwiftPackageGenerateXcodeProject> - method mocked

    open func runSwiftPackageGenerateXcodeProject(_ async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    {
        runSwiftPackageGenerateXcodeProjectCallsCount += 1
        runSwiftPackageGenerateXcodeProjectReceivedAsync = async

        // <runSwiftPackageGenerateXcodeProject> - Void return mock implementation

        runSwiftPackageGenerateXcodeProjectClosure?(async)
    }

    // MARK: - <checkIfSecretsShouldBeHidden> - parameters

    public var checkIfSecretsShouldBeHiddenInThrowableError: Error?
    public var checkIfSecretsShouldBeHiddenInCallsCount = 0
    public var checkIfSecretsShouldBeHiddenInCalled: Bool
    {
        return checkIfSecretsShouldBeHiddenInCallsCount > 0
    }

    public var checkIfSecretsShouldBeHiddenInReceivedFolder: FolderProtocol?

    // MARK: - <checkIfSecretsShouldBeHidden> - closure mocks

    public var checkIfSecretsShouldBeHiddenInClosure: ((FolderProtocol) throws -> Void)?

    // MARK: - <checkIfSecretsShouldBeHidden> - method mocked

    open func checkIfSecretsShouldBeHidden(in folder: FolderProtocol) throws
    {
        // <checkIfSecretsShouldBeHidden> - Throwable method implementation

        if let error = checkIfSecretsShouldBeHiddenInThrowableError
        {
            throw error
        }

        checkIfSecretsShouldBeHiddenInCallsCount += 1
        checkIfSecretsShouldBeHiddenInReceivedFolder = folder

        // <checkIfSecretsShouldBeHidden> - Void return mock implementation

        try checkIfSecretsShouldBeHiddenInClosure?(folder)
    }
}

// MARK: - PackageProtocolMock

open class PackageProtocolMock: PackageProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var dependencies: DependencyProtocol
    {
        get { return underlyingDependencies }
        set(value) { underlyingDependencies = value }
    }

    public var underlyingDependencies: DependencyProtocol!
    public var dump: DumpProtocol
    {
        get { return underlyingDump }
        set(value) { underlyingDump = value }
    }

    public var underlyingDump: DumpProtocol!
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
