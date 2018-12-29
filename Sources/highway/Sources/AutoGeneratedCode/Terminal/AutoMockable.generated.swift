import Terminal
import ZFile
import SourceryAutoProtocols
import Arguments
import Foundation
import ZFileMock
import os


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - ArgumentExecutableProtocolMock

open class ArgumentExecutableProtocolMock: ArgumentExecutableProtocol {

    public init() {}



  // MARK: - <arguments> - parameters

  public var argumentsThrowableError: Error?
  public var argumentsCallsCount = 0
  public var argumentsCalled: Bool {
    return argumentsCallsCount > 0
  }
  public var argumentsReturnValue: Arguments?

  // MARK: - <arguments> - closure mocks

  public var argumentsClosure: (() throws  -> Arguments)? = nil



  // MARK: - <arguments> - method mocked

  open func arguments() throws -> Arguments {


      // <arguments> - Throwable method implementation

    if let error = argumentsThrowableError {
        throw error
    }

      argumentsCallsCount += 1

      // <arguments> - Return Value mock implementation

      guard let closureReturn = argumentsClosure else {
          guard let returnValue = argumentsReturnValue else {
              let message = "No returnValue implemented for argumentsClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <executableFile> - parameters

  public var executableFileThrowableError: Error?
  public var executableFileCallsCount = 0
  public var executableFileCalled: Bool {
    return executableFileCallsCount > 0
  }
  public var executableFileReturnValue: FileProtocol?

  // MARK: - <executableFile> - closure mocks

  public var executableFileClosure: (() throws  -> FileProtocol)? = nil



  // MARK: - <executableFile> - method mocked

  open func executableFile() throws -> FileProtocol {


      // <executableFile> - Throwable method implementation

    if let error = executableFileThrowableError {
        throw error
    }

      executableFileCallsCount += 1

      // <executableFile> - Return Value mock implementation

      guard let closureReturn = executableFileClosure else {
          guard let returnValue = executableFileReturnValue else {
              let message = "No returnValue implemented for executableFileClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - ExecutableProtocolMock

open class ExecutableProtocolMock: ExecutableProtocol {

    public init() {}



  // MARK: - <executableFile> - parameters

  public var executableFileThrowableError: Error?
  public var executableFileCallsCount = 0
  public var executableFileCalled: Bool {
    return executableFileCallsCount > 0
  }
  public var executableFileReturnValue: FileProtocol?

  // MARK: - <executableFile> - closure mocks

  public var executableFileClosure: (() throws  -> FileProtocol)? = nil



  // MARK: - <executableFile> - method mocked

  open func executableFile() throws -> FileProtocol {


      // <executableFile> - Throwable method implementation

    if let error = executableFileThrowableError {
        throw error
    }

      executableFileCallsCount += 1

      // <executableFile> - Return Value mock implementation

      guard let closureReturn = executableFileClosure else {
          guard let returnValue = executableFileReturnValue else {
              let message = "No returnValue implemented for executableFileClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - TerminalWorkerProtocolMock

open class TerminalWorkerProtocolMock: TerminalWorkerProtocol {

    public init() {}



  // MARK: - <terminal> - parameters

  public var terminalTaskThrowableError: Error?
  public var terminalTaskCallsCount = 0
  public var terminalTaskCalled: Bool {
    return terminalTaskCallsCount > 0
  }
  public var terminalTaskReceivedTask: TerminalTask?
  public var terminalTaskReturnValue: [String]?

  // MARK: - <terminal> - closure mocks

  public var terminalTaskClosure: ((TerminalTask) throws  -> [String])? = nil



  // MARK: - <terminal> - method mocked

  open func terminal(task: TerminalTask) throws -> [String] {


      // <terminal> - Throwable method implementation

    if let error = terminalTaskThrowableError {
        throw error
    }

      terminalTaskCallsCount += 1
      terminalTaskReceivedTask = task

      // <terminal> - Return Value mock implementation

      guard let closureReturn = terminalTaskClosure else {
          guard let returnValue = terminalTaskReturnValue else {
              let message = "No returnValue implemented for terminalTaskClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(task)
  }
}


// MARK: - OBJECTIVE-C

