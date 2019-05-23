

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - GitToolProtocolMock

open class GitToolProtocolMock: GitToolProtocol {

    public init() {}



  // MARK: - <isClean> - parameters

  public var isCleanThrowableError: Error?
  public var isCleanCallsCount = 0
  public var isCleanCalled: Bool {
    return isCleanCallsCount > 0
  }
  public var isCleanReturnValue: Bool?

  // MARK: - <isClean> - closure mocks

  public var isCleanClosure: (() throws  -> Bool)? = nil



  // MARK: - <isClean> - method mocked

  open func isClean() throws -> Bool {


      // <isClean> - Throwable method implementation

    if let error = isCleanThrowableError {
        throw error
    }

      isCleanCallsCount += 1

      // <isClean> - Return Value mock implementation

      guard let closureReturn = isCleanClosure else {
          guard let returnValue = isCleanReturnValue else {
              let message = "No returnValue implemented for isCleanClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement Bool

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <status> - parameters

  public var statusThrowableError: Error?
  public var statusCallsCount = 0
  public var statusCalled: Bool {
    return statusCallsCount > 0
  }
  public var statusReturnValue: [String]?

  // MARK: - <status> - closure mocks

  public var statusClosure: (() throws  -> [String])? = nil



  // MARK: - <status> - method mocked

  open func status() throws -> [String] {


      // <status> - Throwable method implementation

    if let error = statusThrowableError {
        throw error
    }

      statusCallsCount += 1

      // <status> - Return Value mock implementation

      guard let closureReturn = statusClosure else {
          guard let returnValue = statusReturnValue else {
              let message = "No returnValue implemented for statusClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <addAll> - parameters

  public var addAllThrowableError: Error?
  public var addAllCallsCount = 0
  public var addAllCalled: Bool {
    return addAllCallsCount > 0
  }
  public var addAllReturnValue: [String]?

  // MARK: - <addAll> - closure mocks

  public var addAllClosure: (() throws  -> [String])? = nil



  // MARK: - <addAll> - method mocked

  open func addAll() throws -> [String] {


      // <addAll> - Throwable method implementation

    if let error = addAllThrowableError {
        throw error
    }

      addAllCallsCount += 1

      // <addAll> - Return Value mock implementation

      guard let closureReturn = addAllClosure else {
          guard let returnValue = addAllReturnValue else {
              let message = "No returnValue implemented for addAllClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <commit> - parameters

  public var commitMessageThrowableError: Error?
  public var commitMessageCallsCount = 0
  public var commitMessageCalled: Bool {
    return commitMessageCallsCount > 0
  }
  public var commitMessageReceivedMessage: String?
  public var commitMessageReturnValue: [String]?

  // MARK: - <commit> - closure mocks

  public var commitMessageClosure: ((String) throws  -> [String])? = nil



  // MARK: - <commit> - method mocked

  open func commit(message: String) throws -> [String] {


      // <commit> - Throwable method implementation

    if let error = commitMessageThrowableError {
        throw error
    }

      commitMessageCallsCount += 1
      commitMessageReceivedMessage = message

      // <commit> - Return Value mock implementation

      guard let closureReturn = commitMessageClosure else {
          guard let returnValue = commitMessageReturnValue else {
              let message = "No returnValue implemented for commitMessageClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn(message)
  }

  // MARK: - <pushToMaster> - parameters

  public var pushToMasterThrowableError: Error?
  public var pushToMasterCallsCount = 0
  public var pushToMasterCalled: Bool {
    return pushToMasterCallsCount > 0
  }
  public var pushToMasterReturnValue: [String]?

  // MARK: - <pushToMaster> - closure mocks

  public var pushToMasterClosure: (() throws  -> [String])? = nil



  // MARK: - <pushToMaster> - method mocked

  open func pushToMaster() throws -> [String] {


      // <pushToMaster> - Throwable method implementation

    if let error = pushToMasterThrowableError {
        throw error
    }

      pushToMasterCallsCount += 1

      // <pushToMaster> - Return Value mock implementation

      guard let closureReturn = pushToMasterClosure else {
          guard let returnValue = pushToMasterReturnValue else {
              let message = "No returnValue implemented for pushToMasterClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <pushTagsToMaster> - parameters

  public var pushTagsToMasterThrowableError: Error?
  public var pushTagsToMasterCallsCount = 0
  public var pushTagsToMasterCalled: Bool {
    return pushTagsToMasterCallsCount > 0
  }
  public var pushTagsToMasterReturnValue: [String]?

  // MARK: - <pushTagsToMaster> - closure mocks

  public var pushTagsToMasterClosure: (() throws  -> [String])? = nil



  // MARK: - <pushTagsToMaster> - method mocked

  open func pushTagsToMaster() throws -> [String] {


      // <pushTagsToMaster> - Throwable method implementation

    if let error = pushTagsToMasterThrowableError {
        throw error
    }

      pushTagsToMasterCallsCount += 1

      // <pushTagsToMaster> - Return Value mock implementation

      guard let closureReturn = pushTagsToMasterClosure else {
          guard let returnValue = pushTagsToMasterReturnValue else {
              let message = "No returnValue implemented for pushTagsToMasterClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <pull> - parameters

  public var pullThrowableError: Error?
  public var pullCallsCount = 0
  public var pullCalled: Bool {
    return pullCallsCount > 0
  }
  public var pullReturnValue: [String]?

  // MARK: - <pull> - closure mocks

  public var pullClosure: (() throws  -> [String])? = nil



  // MARK: - <pull> - method mocked

  open func pull() throws -> [String] {


      // <pull> - Throwable method implementation

    if let error = pullThrowableError {
        throw error
    }

      pullCallsCount += 1

      // <pull> - Return Value mock implementation

      guard let closureReturn = pullClosure else {
          guard let returnValue = pullReturnValue else {
              let message = "No returnValue implemented for pullClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <currentTag> - parameters

  public var currentTagThrowableError: Error?
  public var currentTagCallsCount = 0
  public var currentTagCalled: Bool {
    return currentTagCallsCount > 0
  }
  public var currentTagReturnValue: [String]?

  // MARK: - <currentTag> - closure mocks

  public var currentTagClosure: (() throws  -> [String])? = nil



  // MARK: - <currentTag> - method mocked

  open func currentTag() throws -> [String] {


      // <currentTag> - Throwable method implementation

    if let error = currentTagThrowableError {
        throw error
    }

      currentTagCallsCount += 1

      // <currentTag> - Return Value mock implementation

      guard let closureReturn = currentTagClosure else {
          guard let returnValue = currentTagReturnValue else {
              let message = "No returnValue implemented for currentTagClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <clone> - parameters

  public var cloneWithThrowableError: Error?
  public var cloneWithCallsCount = 0
  public var cloneWithCalled: Bool {
    return cloneWithCallsCount > 0
  }
  public var cloneWithReceivedOptions: CloneOptions?
  public var cloneWithReturnValue: [String]?

  // MARK: - <clone> - closure mocks

  public var cloneWithClosure: ((CloneOptions) throws  -> [String])? = nil



  // MARK: - <clone> - method mocked

  open func clone(with options: CloneOptions) throws -> [String] {


      // <clone> - Throwable method implementation

    if let error = cloneWithThrowableError {
        throw error
    }

      cloneWithCallsCount += 1
      cloneWithReceivedOptions = options

      // <clone> - Return Value mock implementation

      guard let closureReturn = cloneWithClosure else {
          guard let returnValue = cloneWithReturnValue else {
              let message = "No returnValue implemented for cloneWithClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn(options)
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
