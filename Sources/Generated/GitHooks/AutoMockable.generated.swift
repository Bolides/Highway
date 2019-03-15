import Arguments
import Foundation
import GitHooks
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - GitHooksWorkerProtocolMock

open class GitHooksWorkerProtocolMock: GitHooksWorkerProtocol
{
    public init() {}

    public static var prepushBashScript: String
    {
        get { return underlyingPrepushBashScript }
        set(value) { underlyingPrepushBashScript = value }
    }

    public static var underlyingPrepushBashScript: String = "AutoMockable filled value"

    // MARK: - <init> - parameters

    public var initSwiftPackageDependenciesSwiftPackageDumpHwSetupExecutableProductNameGitHooksFolderSignPostReceivedArguments: (swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, hwSetupExecutableProductName: String?, gitHooksFolder: FolderProtocol?, signPost: SignPostProtocol)?

    // MARK: - <init> - closure mocks

    public var initSwiftPackageDependenciesSwiftPackageDumpHwSetupExecutableProductNameGitHooksFolderSignPostClosure: ((DependencyProtocol, DumpProtocol, String?, FolderProtocol?, SignPostProtocol) -> Void)?

    // MARK: - <init> - initializer mocked

    public required init(swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, hwSetupExecutableProductName: String?, gitHooksFolder: FolderProtocol?, signPost: SignPostProtocol)
    {
        initSwiftPackageDependenciesSwiftPackageDumpHwSetupExecutableProductNameGitHooksFolderSignPostReceivedArguments = (swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, hwSetupExecutableProductName: hwSetupExecutableProductName, gitHooksFolder: gitHooksFolder, signPost: signPost)
        initSwiftPackageDependenciesSwiftPackageDumpHwSetupExecutableProductNameGitHooksFolderSignPostClosure?(swiftPackageDependencies, swiftPackageDump, hwSetupExecutableProductName, gitHooksFolder, signPost)
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
