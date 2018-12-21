import Foundation
@testable import Keychain
import SourceryAutoProtocols
import os


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - KeychainProtocolMock

open class KeychainProtocolMock: KeychainProtocol {

    public init() {}

  public  var system: SystemProtocol {
      get { return underlyingSystem }
      set(value) { underlyingSystem = value }
  }
  public  var underlyingSystem: SystemProtocol!


  // MARK: - <password> - parameters

  public var passwordMatchingThrowableError: Error?
  public var passwordMatchingCallsCount = 0
  public var passwordMatchingCalled: Bool {
    return passwordMatchingCallsCount > 0
  }
  public var passwordMatchingReceivedQuery: Keychain.PasswordQuery?
  public var passwordMatchingReturnValue: String?

  // MARK: - <password> - closure mocks

  public var passwordMatchingClosure: ((Keychain.PasswordQuery) throws  -> String)? = nil



  // MARK: - <password> - method mocked

  open func password(matching query: Keychain.PasswordQuery) throws -> String {


      // <password> - Throwable method implementation

    if let error = passwordMatchingThrowableError {
        throw error
    }

      passwordMatchingCallsCount += 1
      passwordMatchingReceivedQuery = query

      // <password> - Return Value mock implementation

      guard let closureReturn = passwordMatchingClosure else {
          guard let returnValue = passwordMatchingReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    passwordMatching
                    but this case(s) is(are) not implemented in
                    KeychainProtocol for method passwordMatchingClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(query)
  }
}


// MARK: - OBJECTIVE-C

