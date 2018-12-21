import SourceryAutoProtocols
import Foundation
import Git
import os


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - GitToolProtocolMock

open class GitToolProtocolMock: GitToolProtocol {

    public init() {}



  // MARK: - <addAll> - parameters

  public var addAllAtThrowableError: Error?
  public var addAllAtCallsCount = 0
  public var addAllAtCalled: Bool {
    return addAllAtCallsCount > 0
  }
  public var addAllAtReceivedUrl: FolderProtocol?

  // MARK: - <addAll> - closure mocks

  public var addAllAtClosure: ((FolderProtocol) throws  -> Void)? = nil



  // MARK: - <addAll> - method mocked

  open func addAll(at url: FolderProtocol) throws {


      // <addAll> - Throwable method implementation

    if let error = addAllAtThrowableError {
        throw error
    }

      addAllAtCallsCount += 1
      addAllAtReceivedUrl = url

      // <addAll> - Void return mock implementation

      try addAllAtClosure?(url)

  }

  // MARK: - <commit> - parameters

  public var commitAtMessageThrowableError: Error?
  public var commitAtMessageCallsCount = 0
  public var commitAtMessageCalled: Bool {
    return commitAtMessageCallsCount > 0
  }
  public var commitAtMessageReceivedArguments: (url: (FolderProtocol), message: (String))?

  // MARK: - <commit> - closure mocks

  public var commitAtMessageClosure: ((FolderProtocol, String) throws  -> Void)? = nil



  // MARK: - <commit> - method mocked

  open func commit(at url: FolderProtocol, message: String) throws {


      // <commit> - Throwable method implementation

    if let error = commitAtMessageThrowableError {
        throw error
    }

      commitAtMessageCallsCount += 1
      commitAtMessageReceivedArguments = (url: url, message: message)

      // <commit> - Void return mock implementation

      try commitAtMessageClosure?(url, message)

  }

  // MARK: - <pushToMaster> - parameters

  public var pushToMasterAtThrowableError: Error?
  public var pushToMasterAtCallsCount = 0
  public var pushToMasterAtCalled: Bool {
    return pushToMasterAtCallsCount > 0
  }
  public var pushToMasterAtReceivedUrl: FolderProtocol?

  // MARK: - <pushToMaster> - closure mocks

  public var pushToMasterAtClosure: ((FolderProtocol) throws  -> Void)? = nil



  // MARK: - <pushToMaster> - method mocked

  open func pushToMaster(at url: FolderProtocol) throws {


      // <pushToMaster> - Throwable method implementation

    if let error = pushToMasterAtThrowableError {
        throw error
    }

      pushToMasterAtCallsCount += 1
      pushToMasterAtReceivedUrl = url

      // <pushToMaster> - Void return mock implementation

      try pushToMasterAtClosure?(url)

  }

  // MARK: - <pushTagsToMaster> - parameters

  public var pushTagsToMasterAtThrowableError: Error?
  public var pushTagsToMasterAtCallsCount = 0
  public var pushTagsToMasterAtCalled: Bool {
    return pushTagsToMasterAtCallsCount > 0
  }
  public var pushTagsToMasterAtReceivedUrl: FolderProtocol?

  // MARK: - <pushTagsToMaster> - closure mocks

  public var pushTagsToMasterAtClosure: ((FolderProtocol) throws  -> Void)? = nil



  // MARK: - <pushTagsToMaster> - method mocked

  open func pushTagsToMaster(at url: FolderProtocol) throws {


      // <pushTagsToMaster> - Throwable method implementation

    if let error = pushTagsToMasterAtThrowableError {
        throw error
    }

      pushTagsToMasterAtCallsCount += 1
      pushTagsToMasterAtReceivedUrl = url

      // <pushTagsToMaster> - Void return mock implementation

      try pushTagsToMasterAtClosure?(url)

  }

  // MARK: - <pull> - parameters

  public var pullAtThrowableError: Error?
  public var pullAtCallsCount = 0
  public var pullAtCalled: Bool {
    return pullAtCallsCount > 0
  }
  public var pullAtReceivedUrl: FolderProtocol?

  // MARK: - <pull> - closure mocks

  public var pullAtClosure: ((FolderProtocol) throws  -> Void)? = nil



  // MARK: - <pull> - method mocked

  open func pull(at url: FolderProtocol) throws {


      // <pull> - Throwable method implementation

    if let error = pullAtThrowableError {
        throw error
    }

      pullAtCallsCount += 1
      pullAtReceivedUrl = url

      // <pull> - Void return mock implementation

      try pullAtClosure?(url)

  }

  // MARK: - <currentTag> - parameters

  public var currentTagAtThrowableError: Error?
  public var currentTagAtCallsCount = 0
  public var currentTagAtCalled: Bool {
    return currentTagAtCallsCount > 0
  }
  public var currentTagAtReceivedUrl: FolderProtocol?
  public var currentTagAtReturnValue: String?

  // MARK: - <currentTag> - closure mocks

  public var currentTagAtClosure: ((FolderProtocol) throws  -> String)? = nil



  // MARK: - <currentTag> - method mocked

  open func currentTag(at url: FolderProtocol) throws -> String {


      // <currentTag> - Throwable method implementation

    if let error = currentTagAtThrowableError {
        throw error
    }

      currentTagAtCallsCount += 1
      currentTagAtReceivedUrl = url

      // <currentTag> - Return Value mock implementation

      guard let closureReturn = currentTagAtClosure else {
          guard let returnValue = currentTagAtReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    currentTagAt
                    but this case(s) is(are) not implemented in
                    GitToolProtocol for method currentTagAtClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(url)
  }

  // MARK: - <clone> - parameters

  public var cloneWithThrowableError: Error?
  public var cloneWithCallsCount = 0
  public var cloneWithCalled: Bool {
    return cloneWithCallsCount > 0
  }
  public var cloneWithReceivedOptions: CloneOptions?

  // MARK: - <clone> - closure mocks

  public var cloneWithClosure: ((CloneOptions) throws  -> Void)? = nil



  // MARK: - <clone> - method mocked

  open func clone(with options: CloneOptions) throws {


      // <clone> - Throwable method implementation

    if let error = cloneWithThrowableError {
        throw error
    }

      cloneWithCallsCount += 1
      cloneWithReceivedOptions = options

      // <clone> - Void return mock implementation

      try cloneWithClosure?(options)

  }
}


// MARK: - OBJECTIVE-C

