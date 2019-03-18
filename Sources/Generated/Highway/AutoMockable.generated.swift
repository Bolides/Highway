import Arguments
import Foundation
import GitHooks
import Highway
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - HighwayProtocolMock

open class HighwayProtocolMock: HighwayProtocol
{
    public init() {}

    public var package: (package: PackageProtocol, executable: String)
    {
        get { return underlyingPackage }
        set(value) { underlyingPackage = value }
    }

    public var underlyingPackage: (package: PackageProtocol, executable: String)!
    public var sourceryBuilder: SourceryBuilderProtocol
    {
        get { return underlyingSourceryBuilder }
        set(value) { underlyingSourceryBuilder = value }
    }

    public var underlyingSourceryBuilder: SourceryBuilderProtocol!
    public var sourceryWorkers: [SourceryWorkerProtocol] = []
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
