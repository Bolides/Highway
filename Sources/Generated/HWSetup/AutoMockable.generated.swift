

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - HWSetupSourceryWorkerWorkerProtocolMock

open class HWSetupSourceryWorkerWorkerProtocolMock: HWSetupSourceryWorkerWorkerProtocol {

    public init() {}



  // MARK: - <attempt> - parameters

  public var attemptThrowableError: Error?
  public var attemptCallsCount = 0
  public var attemptCalled: Bool {
    return attemptCallsCount > 0
  }
  public var attemptReceivedAsync: ((@escaping SourceryWorker.SyncOutput) -> Void)?

  // MARK: - <attempt> - closure mocks

  public var attemptClosure: ((@escaping (@escaping SourceryWorker.SyncOutput) -> Void) throws  -> Void)? = nil



  // MARK: - <attempt> - method mocked

  open func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) throws {


      // <attempt> - Throwable method implementation

    if let error = attemptThrowableError {
        throw error
    }

      attemptCallsCount += 1
      attemptReceivedAsync = async

      // <attempt> - Void return mock implementation

        try attemptClosure?(async)

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
