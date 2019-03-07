import Arguments
import Foundation
import os
import SourceryAutoProtocols
import ZFile
import ZFileMock


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared
















// MARK: - ArgumentsWorkerProtocolMock

open class ArgumentsWorkerProtocolMock: ArgumentsWorkerProtocol {

    public init() {}

  public var workers: [Worker] = []

}


// MARK: - SwiftPackageDumpProtocolMock

open class SwiftPackageDumpProtocolMock: SwiftPackageDumpProtocol {

    public init() {}

  public  var products: Set<SwiftProduct> {
      get { return underlyingProducts }
      set(value) { underlyingProducts = value }
  }
  public  var underlyingProducts: Set<SwiftProduct>!

}


// MARK: - SwiftPackageProtocolMock

open class SwiftPackageProtocolMock: SwiftPackageProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var url: URL {
      get { return underlyingUrl }
      set(value) { underlyingUrl = value }
  }
  public  var underlyingUrl: URL!


  // MARK: - <srcRoot> - parameters

  public var srcRootThrowableError: Error?
  public var srcRootCallsCount = 0
  public var srcRootCalled: Bool {
    return srcRootCallsCount > 0
  }
  public var srcRootReturnValue: FolderProtocol?

  // MARK: - <srcRoot> - closure mocks

  public var srcRootClosure: (() throws  -> FolderProtocol)? = nil



  // MARK: - <srcRoot> - method mocked

  open func srcRoot() throws -> FolderProtocol {


      // <srcRoot> - Throwable method implementation

    if let error = srcRootThrowableError {
        throw error
    }

      srcRootCallsCount += 1

      // <srcRoot> - Return Value mock implementation

      guard let closureReturn = srcRootClosure else {
          guard let returnValue = srcRootReturnValue else {
              let message = "No returnValue implemented for srcRootClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement FolderProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <templateFolder> - parameters

  public var templateFolderThrowableError: Error?
  public var templateFolderCallsCount = 0
  public var templateFolderCalled: Bool {
    return templateFolderCallsCount > 0
  }
  public var templateFolderReturnValue: FolderProtocol?

  // MARK: - <templateFolder> - closure mocks

  public var templateFolderClosure: (() throws  -> FolderProtocol)? = nil



  // MARK: - <templateFolder> - method mocked

  open func templateFolder() throws -> FolderProtocol {


      // <templateFolder> - Throwable method implementation

    if let error = templateFolderThrowableError {
        throw error
    }

      templateFolderCallsCount += 1

      // <templateFolder> - Return Value mock implementation

      guard let closureReturn = templateFolderClosure else {
          guard let returnValue = templateFolderReturnValue else {
              let message = "No returnValue implemented for templateFolderClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement FolderProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <sourceryFolder> - parameters

  public var sourceryFolderThrowableError: Error?
  public var sourceryFolderCallsCount = 0
  public var sourceryFolderCalled: Bool {
    return sourceryFolderCallsCount > 0
  }
  public var sourceryFolderReturnValue: FolderProtocol?

  // MARK: - <sourceryFolder> - closure mocks

  public var sourceryFolderClosure: (() throws  -> FolderProtocol)? = nil



  // MARK: - <sourceryFolder> - method mocked

  open func sourceryFolder() throws -> FolderProtocol {


      // <sourceryFolder> - Throwable method implementation

    if let error = sourceryFolderThrowableError {
        throw error
    }

      sourceryFolderCallsCount += 1

      // <sourceryFolder> - Return Value mock implementation

      guard let closureReturn = sourceryFolderClosure else {
          guard let returnValue = sourceryFolderReturnValue else {
              let message = "No returnValue implemented for sourceryFolderClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement FolderProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - SwiftProductProtocolMock

open class SwiftProductProtocolMock: SwiftProductProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"

}


// MARK: - OBJECTIVE-C

