import Foundation
import os
import SourceryAutoProtocols
import SwiftformatWorker
import ZFile
import ZFileMock


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - SwiftFormatWorkerProtocolMock

open class SwiftFormatWorkerProtocolMock: SwiftFormatWorkerProtocol {

    public init() {}

  public static var queue: DispatchQueue {
      get { return underlyingQueue }
      set(value) { underlyingQueue = value }
  }
  public static var underlyingQueue: DispatchQueue!
  public  var queue: DispatchQueue {
      get { return underlyingQueue }
      set(value) { underlyingQueue = value }
  }
  public  var underlyingQueue: DispatchQueue!


  // MARK: - <attempt> - parameters

  public var attemptCallsCount = 0
  public var attemptCalled: Bool {
    return attemptCallsCount > 0
  }
  public var attemptReceivedAsyncSwiftFormatAttemptOutput: ((@escaping SwiftFormatWorker.SyncOutput) -> Void)?

  // MARK: - <attempt> - closure mocks

  public var attemptClosure: ((@escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void)  -> Void)? = nil



  // MARK: - <attempt> - method mocked

  open func attempt(_ asyncSwiftFormatAttemptOutput: @escaping (@escaping SwiftFormatWorker.SyncOutput) -> Void) {

      attemptCallsCount += 1
      attemptReceivedAsyncSwiftFormatAttemptOutput = asyncSwiftFormatAttemptOutput

      // <attempt> - Void return mock implementation

      attemptClosure?(asyncSwiftFormatAttemptOutput)

  }
}


// MARK: - OBJECTIVE-C

