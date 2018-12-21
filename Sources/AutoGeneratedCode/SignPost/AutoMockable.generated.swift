import Foundation
import SourceryAutoProtocols
import os
import SignPost


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - SignPostProtocolMock

open class SignPostProtocolMock: SignPostProtocol {

    public init() {}

  public static var shared: SignPostProtocol {
      get { return underlyingShared }
      set(value) { underlyingShared = value }
  }
  public static var underlyingShared: SignPostProtocol!
  public  var verbose: Bool {
      get { return underlyingVerbose }
      set(value) { underlyingVerbose = value }
  }
  public  var underlyingVerbose: Bool = false


  // MARK: - <write> - parameters

  public var writePrinterCallsCount = 0
  public var writePrinterCalled: Bool {
    return writePrinterCallsCount > 0
  }
  public var writePrinterReceivedPrinter: Printer?

  // MARK: - <write> - closure mocks

  public var writePrinterClosure: ((Printer)  -> Void)? = nil



  // MARK: - <write> - method mocked

  open func write(printer: Printer) {

      writePrinterCallsCount += 1
      writePrinterReceivedPrinter = printer

      // <write> - Void return mock implementation

      writePrinterClosure?(printer)

  }

  // MARK: - <write> - parameters

  public var writePrintableCallsCount = 0
  public var writePrintableCalled: Bool {
    return writePrintableCallsCount > 0
  }
  public var writePrintableReceivedPrintable: Printable?

  // MARK: - <write> - closure mocks

  public var writePrintableClosure: ((Printable)  -> Void)? = nil



  // MARK: - <write> - method mocked

  open func write(printable: Printable) {

      writePrintableCallsCount += 1
      writePrintableReceivedPrintable = printable

      // <write> - Void return mock implementation

      writePrintableClosure?(printable)

  }

  // MARK: - <error> - parameters

  public var errorCallsCount = 0
  public var errorCalled: Bool {
    return errorCallsCount > 0
  }
  public var errorReceivedText: String?

  // MARK: - <error> - closure mocks

  public var errorClosure: ((String)  -> Void)? = nil



  // MARK: - <error> - method mocked

  open func error(_ text: String) {

      errorCallsCount += 1
      errorReceivedText = text

      // <error> - Void return mock implementation

      errorClosure?(text)

  }

  // MARK: - <success> - parameters

  public var successCallsCount = 0
  public var successCalled: Bool {
    return successCallsCount > 0
  }
  public var successReceivedText: String?

  // MARK: - <success> - closure mocks

  public var successClosure: ((String)  -> Void)? = nil



  // MARK: - <success> - method mocked

  open func success(_ text: String) {

      successCallsCount += 1
      successReceivedText = text

      // <success> - Void return mock implementation

      successClosure?(text)

  }

  // MARK: - <message> - parameters

  public var messageCallsCount = 0
  public var messageCalled: Bool {
    return messageCallsCount > 0
  }
  public var messageReceivedText: String?

  // MARK: - <message> - closure mocks

  public var messageClosure: ((String)  -> Void)? = nil



  // MARK: - <message> - method mocked

  open func message(_ text: String) {

      messageCallsCount += 1
      messageReceivedText = text

      // <message> - Void return mock implementation

      messageClosure?(text)

  }

  // MARK: - <verbose> - parameters

  public var verboseCallsCount = 0
  public var verboseCalled: Bool {
    return verboseCallsCount > 0
  }
  public var verboseReceivedText: String?

  // MARK: - <verbose> - closure mocks

  public var verboseClosure: ((String)  -> Void)? = nil



  // MARK: - <verbose> - method mocked

  open func verbose(_ text: String) {

      verboseCallsCount += 1
      verboseReceivedText = text

      // <verbose> - Void return mock implementation

      verboseClosure?(text)

  }

  // MARK: - <print> - parameters

  public var printCallsCount = 0
  public var printCalled: Bool {
    return printCallsCount > 0
  }
  public var printReceivedPrintable: Printable?

  // MARK: - <print> - closure mocks

  public var printClosure: ((Printable)  -> Void)? = nil



  // MARK: - <print> - method mocked

  open func print(_ printable: Printable) {

      printCallsCount += 1
      printReceivedPrintable = printable

      // <print> - Void return mock implementation

      printClosure?(printable)

  }

  // MARK: - <verbosePrint> - parameters

  public var verbosePrintCallsCount = 0
  public var verbosePrintCalled: Bool {
    return verbosePrintCallsCount > 0
  }
  public var verbosePrintReceivedPrintable: Printable?

  // MARK: - <verbosePrint> - closure mocks

  public var verbosePrintClosure: ((Printable)  -> Void)? = nil



  // MARK: - <verbosePrint> - method mocked

  open func verbosePrint(_ printable: Printable) {

      verbosePrintCallsCount += 1
      verbosePrintReceivedPrintable = printable

      // <verbosePrint> - Void return mock implementation

      verbosePrintClosure?(printable)

  }
}


// MARK: - OBJECTIVE-C

