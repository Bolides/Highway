import Foundation
import os
import SourceryAutoProtocols
import SourceryWorker
import ZFile
import ZFileMock


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - ImportProtocolMock

open class ImportProtocolMock: ImportProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var testable: Bool {
      get { return underlyingTestable }
      set(value) { underlyingTestable = value }
  }
  public  var underlyingTestable: Bool = false

}


// MARK: - SourceryBuilderProtocolMock

open class SourceryBuilderProtocolMock: SourceryBuilderProtocol {

    public init() {}

  public static var buildPath: String {
      get { return underlyingBuildPath }
      set(value) { underlyingBuildPath = value }
  }
  public static var underlyingBuildPath: String = "AutoMockable filled value"
  public static var executalbeName: String {
      get { return underlyingExecutalbeName }
      set(value) { underlyingExecutalbeName = value }
  }
  public static var underlyingExecutalbeName: String = "AutoMockable filled value"


  // MARK: - <attemptToBuildSourceryIfNeeded> - parameters

  public var attemptToBuildSourceryIfNeededThrowableError: Error?
  public var attemptToBuildSourceryIfNeededCallsCount = 0
  public var attemptToBuildSourceryIfNeededCalled: Bool {
    return attemptToBuildSourceryIfNeededCallsCount > 0
  }
  public var attemptToBuildSourceryIfNeededReturnValue: FileProtocol?

  // MARK: - <attemptToBuildSourceryIfNeeded> - closure mocks

  public var attemptToBuildSourceryIfNeededClosure: (() throws  -> FileProtocol)? = nil



  // MARK: - <attemptToBuildSourceryIfNeeded> - method mocked

  open func attemptToBuildSourceryIfNeeded() throws -> FileProtocol {


      // <attemptToBuildSourceryIfNeeded> - Throwable method implementation

    if let error = attemptToBuildSourceryIfNeededThrowableError {
        throw error
    }

      attemptToBuildSourceryIfNeededCallsCount += 1

      // <attemptToBuildSourceryIfNeeded> - Return Value mock implementation

      guard let closureReturn = attemptToBuildSourceryIfNeededClosure else {
          guard let returnValue = attemptToBuildSourceryIfNeededReturnValue else {
              let message = "No returnValue implemented for attemptToBuildSourceryIfNeededClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - SourceryExecutableFileProtocolMock

open class SourceryExecutableFileProtocolMock: FileProtocolMock, SourceryExecutableFileProtocol {



}


// MARK: - TemplatePrependProtocolMock

open class TemplatePrependProtocolMock: TemplatePrependProtocol {

    public init() {}

  public  var names: Set<TemplatePrepend.Import> {
      get { return underlyingNames }
      set(value) { underlyingNames = value }
  }
  public  var underlyingNames: Set<TemplatePrepend.Import>!
  public  var template: String {
      get { return underlyingTemplate }
      set(value) { underlyingTemplate = value }
  }
  public  var underlyingTemplate: String = "AutoMockable filled value"

}


// MARK: - OBJECTIVE-C

