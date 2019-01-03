import Arguments
import Foundation
import os
import SignPost
import SourceryAutoProtocols
import Task
import ZFile
import ZFileMock


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - ExecutableProviderProtocolMock

open class ExecutableProviderProtocolMock: ExecutableProviderProtocol {

    public init() {}

  public var searchedUrls: [FolderProtocol] = []
  public  var fileSystem: FileSystemProtocol {
      get { return underlyingFileSystem }
      set(value) { underlyingFileSystem = value }
  }
  public  var underlyingFileSystem: FileSystemProtocol!


  // MARK: - <executable> - parameters

  public var executableWithThrowableError: Error?
  public var executableWithCallsCount = 0
  public var executableWithCalled: Bool {
    return executableWithCallsCount > 0
  }
  public var executableWithReceivedExecutableName: String?
  public var executableWithReturnValue: FileProtocol?

  // MARK: - <executable> - closure mocks

  public var executableWithClosure: ((String) throws  -> FileProtocol)? = nil



  // MARK: - <executable> - method mocked

  open func executable(with executableName: String) throws -> FileProtocol {


      // <executable> - Throwable method implementation

    if let error = executableWithThrowableError {
        throw error
    }

      executableWithCallsCount += 1
      executableWithReceivedExecutableName = executableName

      // <executable> - Return Value mock implementation

      guard let closureReturn = executableWithClosure else {
          guard let returnValue = executableWithReturnValue else {
              let message = "No returnValue implemented for executableWithClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(executableName)
  }
}


// MARK: - SystemExecutorProtocolMock

open class SystemExecutorProtocolMock: SystemExecutorProtocol {

    public init() {}

  public  var signPost: SignPostProtocol {
      get { return underlyingSignPost }
      set(value) { underlyingSignPost = value }
  }
  public  var underlyingSignPost: SignPostProtocol!


  // MARK: - <launch> - parameters

  public var launchTaskWaitThrowableError: Error?
  public var launchTaskWaitCallsCount = 0
  public var launchTaskWaitCalled: Bool {
    return launchTaskWaitCallsCount > 0
  }
  public var launchTaskWaitReceivedArguments: (task: (Task), wait: (Bool))?

  // MARK: - <launch> - closure mocks

  public var launchTaskWaitClosure: ((Task, Bool) throws  -> Void)? = nil



  // MARK: - <launch> - method mocked

  open func launch(task: Task, wait: Bool) throws {


      // <launch> - Throwable method implementation

    if let error = launchTaskWaitThrowableError {
        throw error
    }

      launchTaskWaitCallsCount += 1
      launchTaskWaitReceivedArguments = (task: task, wait: wait)

      // <launch> - Void return mock implementation

      try launchTaskWaitClosure?(task, wait)

  }
}


// MARK: - SystemProtocolMock

open class SystemProtocolMock: SystemProtocol {

    public init() {}



  // MARK: - <task> - parameters

  public var taskNamedThrowableError: Error?
  public var taskNamedCallsCount = 0
  public var taskNamedCalled: Bool {
    return taskNamedCallsCount > 0
  }
  public var taskNamedReceivedName: String?
  public var taskNamedReturnValue: Task?

  // MARK: - <task> - closure mocks

  public var taskNamedClosure: ((String) throws  -> Task)? = nil



  // MARK: - <task> - method mocked

  open func task(named name: String) throws -> Task {


      // <task> - Throwable method implementation

    if let error = taskNamedThrowableError {
        throw error
    }

      taskNamedCallsCount += 1
      taskNamedReceivedName = name

      // <task> - Return Value mock implementation

      guard let closureReturn = taskNamedClosure else {
          guard let returnValue = taskNamedReturnValue else {
              let message = "No returnValue implemented for taskNamedClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(name)
  }

  // MARK: - <execute> - parameters

  public var executeThrowableError: Error?
  public var executeCallsCount = 0
  public var executeCalled: Bool {
    return executeCallsCount > 0
  }
  public var executeReceivedTask: Task?
  public var executeReturnValue: Bool?

  // MARK: - <execute> - closure mocks

  public var executeClosure: ((Task) throws  -> Bool)? = nil



  // MARK: - <execute> - method mocked

  open func execute(_ task: Task) throws -> Bool {


      // <execute> - Throwable method implementation

    if let error = executeThrowableError {
        throw error
    }

      executeCallsCount += 1
      executeReceivedTask = task

      // <execute> - Return Value mock implementation

      guard let closureReturn = executeClosure else {
          guard let returnValue = executeReturnValue else {
              let message = "No returnValue implemented for executeClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(task)
  }

  // MARK: - <launch> - parameters

  public var launchWaitThrowableError: Error?
  public var launchWaitCallsCount = 0
  public var launchWaitCalled: Bool {
    return launchWaitCallsCount > 0
  }
  public var launchWaitReceivedArguments: (task: (Task), wait: (Bool))?
  public var launchWaitReturnValue: Bool?

  // MARK: - <launch> - closure mocks

  public var launchWaitClosure: ((Task, Bool) throws  -> Bool)? = nil



  // MARK: - <launch> - method mocked

  open func launch(_ task: Task, wait: Bool) throws -> Bool {


      // <launch> - Throwable method implementation

    if let error = launchWaitThrowableError {
        throw error
    }

      launchWaitCallsCount += 1
      launchWaitReceivedArguments = (task: task, wait: wait)

      // <launch> - Return Value mock implementation

      guard let closureReturn = launchWaitClosure else {
          guard let returnValue = launchWaitReturnValue else {
              let message = "No returnValue implemented for launchWaitClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(task, wait)
  }
}


// MARK: - TaskProtocolMock

open class TaskProtocolMock: TaskProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var executable: FileProtocol {
      get { return underlyingExecutable }
      set(value) { underlyingExecutable = value }
  }
  public  var underlyingExecutable: FileProtocol!
  public  var arguments: Arguments {
      get { return underlyingArguments }
      set(value) { underlyingArguments = value }
  }
  public  var underlyingArguments: Arguments!
  public var environment: [String: String] = [:]
  public var currentDirectoryUrl: FolderProtocol?
  public  var input: Channel {
      get { return underlyingInput }
      set(value) { underlyingInput = value }
  }
  public  var underlyingInput: Channel!
  public  var output: Channel {
      get { return underlyingOutput }
      set(value) { underlyingOutput = value }
  }
  public  var underlyingOutput: Channel!
  public  var state: State {
      get { return underlyingState }
      set(value) { underlyingState = value }
  }
  public  var underlyingState: State!
  public var capturedOutputData: Data?
  public var readOutputString: String?
  public var trimmedOutput: String?
  public var capturedOutputString: String?
  public  var successfullyFinished: Bool {
      get { return underlyingSuccessfullyFinished }
      set(value) { underlyingSuccessfullyFinished = value }
  }
  public  var underlyingSuccessfullyFinished: Bool = false
  public  var description: String {
      get { return underlyingDescription }
      set(value) { underlyingDescription = value }
  }
  public  var underlyingDescription: String = "AutoMockable filled value"


  // MARK: - <enableReadableOutputDataCapturing> - parameters

  public var enableReadableOutputDataCapturingCallsCount = 0
  public var enableReadableOutputDataCapturingCalled: Bool {
    return enableReadableOutputDataCapturingCallsCount > 0
  }

  // MARK: - <enableReadableOutputDataCapturing> - closure mocks

  public var enableReadableOutputDataCapturingClosure: (()  -> Void)? = nil



  // MARK: - <enableReadableOutputDataCapturing> - method mocked

  open func enableReadableOutputDataCapturing() {

      enableReadableOutputDataCapturingCallsCount += 1

      // <enableReadableOutputDataCapturing> - Void return mock implementation

      enableReadableOutputDataCapturingClosure?()

  }

  // MARK: - <throwIfNotSuccess> - parameters

  public var throwIfNotSuccessThrowableError: Error?
  public var throwIfNotSuccessCallsCount = 0
  public var throwIfNotSuccessCalled: Bool {
    return throwIfNotSuccessCallsCount > 0
  }
  public var throwIfNotSuccessReceivedError: Swift.Error?

  // MARK: - <throwIfNotSuccess> - closure mocks

  public var throwIfNotSuccessClosure: ((Swift.Error) throws  -> Void)? = nil



  // MARK: - <throwIfNotSuccess> - method mocked

  open func throwIfNotSuccess(_ error: Swift.Error) throws {


      // <throwIfNotSuccess> - Throwable method implementation

    if let error = throwIfNotSuccessThrowableError {
        throw error
    }

      throwIfNotSuccessCallsCount += 1
      throwIfNotSuccessReceivedError = error

      // <throwIfNotSuccess> - Void return mock implementation

      try throwIfNotSuccessClosure?(error)

  }
}


// MARK: - OBJECTIVE-C

