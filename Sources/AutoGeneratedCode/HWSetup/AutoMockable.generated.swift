import Foundation
import HWSetup
import os
import SourceryAutoProtocols
import ZFile
import ZFileMock


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared
















// MARK: - HWSetupSourceryWorkerWorkerProtocolMock

open class HWSetupSourceryWorkerWorkerProtocolMock: HWSetupSourceryWorkerWorkerProtocol {

    public init() {}



  // MARK: - <attempt> - parameters

  public var attemptCallsCount = 0
  public var attemptCalled: Bool {
    return attemptCallsCount > 0
  }
  public var attemptReceivedAsync: ((@escaping SourceryWorker.SyncOutput) -> Void)?

  // MARK: - <attempt> - closure mocks

  public var attemptClosure: ((@escaping (@escaping SourceryWorker.SyncOutput) -> Void)  -> Void)? = nil



  // MARK: - <attempt> - method mocked

  open func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) {

      attemptCallsCount += 1
      attemptReceivedAsync = async

      // <attempt> - Void return mock implementation

        attemptClosure?(async)

  }
}


// MARK: - OBJECTIVE-C

