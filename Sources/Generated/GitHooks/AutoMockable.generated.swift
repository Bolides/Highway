import Errors
import Foundation
import GitHooks
import HighwayDispatch
import Result
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - GitHooksWorkerProtocolMock

open class GitHooksWorkerProtocolMock: GitHooksWorkerProtocol
{
    public init() {}

    public static var defaultOptions: String
    {
        get { return underlyingDefaultOptions }
        set(value) { underlyingDefaultOptions = value }
    }

    public static var underlyingDefaultOptions: String = "AutoMockable filled value"
    public static var prepushBashScript: String
    {
        get { return underlyingPrepushBashScript }
        set(value) { underlyingPrepushBashScript = value }
    }

    public static var underlyingPrepushBashScript: String = "AutoMockable filled value"

    // MARK: - <init> - parameters

    public var initSwiftPackageDependenciesSwiftPackageDumpCommandlineOptionsHwSetupExecutableProductNamePrePushScriptCommandlineOptionsGitHooksFolderSignPostReceivedArguments: (swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, commandlineOptions: Set<GitHooksWorker.Option>, hwSetupExecutableProductName: String?, prePushScriptCommandlineOptions: String?, gitHooksFolder: FolderProtocol?, signPost: SignPostProtocol)?

    // MARK: - <init> - closure mocks

    public var initSwiftPackageDependenciesSwiftPackageDumpCommandlineOptionsHwSetupExecutableProductNamePrePushScriptCommandlineOptionsGitHooksFolderSignPostClosure: ((DependencyProtocol, DumpProtocol, Set<GitHooksWorker.Option>, String?, String?, FolderProtocol?, SignPostProtocol) -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, commandlineOptions: Set<GitHooksWorker.Option>, hwSetupExecutableProductName: String?, prePushScriptCommandlineOptions: String?, gitHooksFolder: FolderProtocol?, signPost: SignPostProtocol)
    {
        initSwiftPackageDependenciesSwiftPackageDumpCommandlineOptionsHwSetupExecutableProductNamePrePushScriptCommandlineOptionsGitHooksFolderSignPostReceivedArguments = (swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, commandlineOptions: commandlineOptions, hwSetupExecutableProductName: hwSetupExecutableProductName, prePushScriptCommandlineOptions: prePushScriptCommandlineOptions, gitHooksFolder: gitHooksFolder, signPost: signPost)
        initSwiftPackageDependenciesSwiftPackageDumpCommandlineOptionsHwSetupExecutableProductNamePrePushScriptCommandlineOptionsGitHooksFolderSignPostClosure?(swiftPackageDependencies, swiftPackageDump, commandlineOptions, hwSetupExecutableProductName, prePushScriptCommandlineOptions, gitHooksFolder, signPost)
    }

    // MARK: - <addPrePushToGitHooks> - parameters

    public var addPrePushToGitHooksThrowableError: Error?
    public var addPrePushToGitHooksCallsCount = 0
    public var addPrePushToGitHooksCalled: Bool
    {
        return addPrePushToGitHooksCallsCount > 0
    }

    // MARK: - <addPrePushToGitHooks> - closure mocks

    public var addPrePushToGitHooksClosure: (() throws -> Void)?

    // MARK: - <addPrePushToGitHooks> - method mocked

    open func addPrePushToGitHooks() throws
    {
        // <addPrePushToGitHooks> - Throwable method implementation

        if let error = addPrePushToGitHooksThrowableError
        {
            throw error
        }

        addPrePushToGitHooksCallsCount += 1

        // <addPrePushToGitHooks> - Void return mock implementation

        try addPrePushToGitHooksClosure?()
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
