import Foundation
import HighwayDispatch
import SourceryAutoProtocols


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - HWDispatchGroupProtocolMock

open class HWDispatchGroupProtocolMock: HWDispatchGroupProtocol {

    public init() {}



  // MARK: - <leave> - parameters

  public var leaveCallsCount = 0
  public var leaveCalled: Bool {
    return leaveCallsCount > 0
  }

  // MARK: - <leave> - closure mocks

  public var leaveClosure: (()  -> Void)? = nil



  // MARK: - <leave> - method mocked

  open func leave() {

      leaveCallsCount += 1

      // <leave> - Void return mock implementation

        leaveClosure?()

  }

  // MARK: - <enter> - parameters

  public var enterCallsCount = 0
  public var enterCalled: Bool {
    return enterCallsCount > 0
  }

  // MARK: - <enter> - closure mocks

  public var enterClosure: (()  -> Void)? = nil



  // MARK: - <enter> - method mocked

  open func enter() {

      enterCallsCount += 1

      // <enter> - Void return mock implementation

        enterClosure?()

  }

  // MARK: - <wait> - parameters

  public var waitCallsCount = 0
  public var waitCalled: Bool {
    return waitCallsCount > 0
  }

  // MARK: - <wait> - closure mocks

  public var waitClosure: (()  -> Void)? = nil



  // MARK: - <wait> - method mocked

  open func wait() {

      waitCallsCount += 1

      // <wait> - Void return mock implementation

        waitClosure?()

  }

  // MARK: - <notifyMain> - parameters

  public var notifyMainExecuteCallsCount = 0
  public var notifyMainExecuteCalled: Bool {
    return notifyMainExecuteCallsCount > 0
  }
  public var notifyMainExecuteReceivedWork: (() -> Void)?

  // MARK: - <notifyMain> - closure mocks

  public var notifyMainExecuteClosure: ((@escaping @convention(block) () -> Void)  -> Void)? = nil



  // MARK: - <notifyMain> - method mocked

  open func notifyMain(execute work: @escaping @convention(block) () -> Void) {

      notifyMainExecuteCallsCount += 1
      notifyMainExecuteReceivedWork = work

      // <notifyMain> - Void return mock implementation

        notifyMainExecuteClosure?(work)

  }
}


// MARK: - HighwayDispatchProtocolMock

open class HighwayDispatchProtocolMock: HighwayDispatchProtocol {

    public init() {}



  // MARK: - <async> - parameters

  public var asyncSyncCallsCount = 0
  public var asyncSyncCalled: Bool {
    return asyncSyncCallsCount > 0
  }
  public var asyncSyncReceivedSync: (() -> Void)?

  // MARK: - <async> - closure mocks

  public var asyncSyncClosure: ((@escaping () -> Void)  -> Void)? = nil



  // MARK: - <async> - method mocked

  open func async(sync: @escaping () -> Void) {

      asyncSyncCallsCount += 1
      asyncSyncReceivedSync = sync

      // <async> - Void return mock implementation

        asyncSyncClosure?(sync)

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
