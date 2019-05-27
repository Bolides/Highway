

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - HWPodProtocolMock

open class HWPodProtocolMock: HWPodProtocol
{
    public init() {}

    public static var expectedCocoapodsVersion: String
    {
        get { return underlyingExpectedCocoapodsVersion }
        set(value) { underlyingExpectedCocoapodsVersion = value }
    }

    public static var underlyingExpectedCocoapodsVersion: String = "AutoMockable filled value"

    // MARK: - <attemptPodInstallIfOptionAddedToCommandline> - parameters

    public var attemptPodInstallIfOptionAddedToCommandlineThrowableError: Error?
    public var attemptPodInstallIfOptionAddedToCommandlineCallsCount = 0
    public var attemptPodInstallIfOptionAddedToCommandlineCalled: Bool
    {
        return attemptPodInstallIfOptionAddedToCommandlineCallsCount > 0
    }

    // MARK: - <attemptPodInstallIfOptionAddedToCommandline> - closure mocks

    public var attemptPodInstallIfOptionAddedToCommandlineClosure: (() throws -> Void)?

    // MARK: - <attemptPodInstallIfOptionAddedToCommandline> - method mocked

    open func attemptPodInstallIfOptionAddedToCommandline() throws
    {
        // <attemptPodInstallIfOptionAddedToCommandline> - Throwable method implementation

        if let error = attemptPodInstallIfOptionAddedToCommandlineThrowableError
        {
            throw error
        }

        attemptPodInstallIfOptionAddedToCommandlineCallsCount += 1

        // <attemptPodInstallIfOptionAddedToCommandline> - Void return mock implementation

        try attemptPodInstallIfOptionAddedToCommandlineClosure?()
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
