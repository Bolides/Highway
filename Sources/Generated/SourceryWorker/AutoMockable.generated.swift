import Arguments
import Foundation
import HighwayDispatch
import SignPost
import SourceryWorker
import Terminal
import TerminalMock
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

  public static var executalbeFolderPath: String {
      get { return underlyingExecutalbeFolderPath }
      set(value) { underlyingExecutalbeFolderPath = value }
  }
  public static var underlyingExecutalbeFolderPath: String = "AutoMockable filled value"


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

  // MARK: - <sourceryAutoProtocolFile> - parameters

  public var sourceryAutoProtocolFileThrowableError: Error?
  public var sourceryAutoProtocolFileCallsCount = 0
  public var sourceryAutoProtocolFileCalled: Bool {
    return sourceryAutoProtocolFileCallsCount > 0
  }
  public var sourceryAutoProtocolFileReturnValue: FileProtocol?

  // MARK: - <sourceryAutoProtocolFile> - closure mocks

  public var sourceryAutoProtocolFileClosure: (() throws  -> FileProtocol)? = nil



  // MARK: - <sourceryAutoProtocolFile> - method mocked

  open func sourceryAutoProtocolFile() throws -> FileProtocol {


      // <sourceryAutoProtocolFile> - Throwable method implementation

    if let error = sourceryAutoProtocolFileThrowableError {
        throw error
    }

      sourceryAutoProtocolFileCallsCount += 1

      // <sourceryAutoProtocolFile> - Return Value mock implementation

      guard let closureReturn = sourceryAutoProtocolFileClosure else {
          guard let returnValue = sourceryAutoProtocolFileReturnValue else {
              let message = "No returnValue implemented for sourceryAutoProtocolFileClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <dependencies> - parameters

  public var dependenciesThrowableError: Error?
  public var dependenciesCallsCount = 0
  public var dependenciesCalled: Bool {
    return dependenciesCallsCount > 0
  }
  public var dependenciesReturnValue: DependencyProtocol?

  // MARK: - <dependencies> - closure mocks

  public var dependenciesClosure: (() throws  -> DependencyProtocol)? = nil



  // MARK: - <dependencies> - method mocked

  open func dependencies() throws -> DependencyProtocol {


      // <dependencies> - Throwable method implementation

    if let error = dependenciesThrowableError {
        throw error
    }

      dependenciesCallsCount += 1

      // <dependencies> - Return Value mock implementation

      guard let closureReturn = dependenciesClosure else {
          guard let returnValue = dependenciesReturnValue else {
              let message = "No returnValue implemented for dependenciesClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement DependencyProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

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


// MARK: - SourceryProtocolMock

open class SourceryProtocolMock: SourceryProtocol {

    public init() {}

  public  var uuid: String {
      get { return underlyingUuid }
      set(value) { underlyingUuid = value }
  }
  public  var underlyingUuid: String = "AutoMockable filled value"
  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var templateFolder: FolderProtocol {
      get { return underlyingTemplateFolder }
      set(value) { underlyingTemplateFolder = value }
  }
  public  var underlyingTemplateFolder: FolderProtocol!
  public  var outputFolder: FolderProtocol {
      get { return underlyingOutputFolder }
      set(value) { underlyingOutputFolder = value }
  }
  public  var underlyingOutputFolder: FolderProtocol!
  public var sourcesFolders: [FolderProtocol] = []
  public var individualSourceFiles: [File]?
  public  var sourceryAutoProtocolsFile: FileProtocol {
      get { return underlyingSourceryAutoProtocolsFile }
      set(value) { underlyingSourceryAutoProtocolsFile = value }
  }
  public  var underlyingSourceryAutoProtocolsFile: FileProtocol!
  public  var sourceryYMLFile: FileProtocol {
      get { return underlyingSourceryYMLFile }
      set(value) { underlyingSourceryYMLFile = value }
  }
  public  var underlyingSourceryYMLFile: FileProtocol!
  public  var sourceryBuilder: SourceryBuilderProtocol {
      get { return underlyingSourceryBuilder }
      set(value) { underlyingSourceryBuilder = value }
  }
  public  var underlyingSourceryBuilder: SourceryBuilderProtocol!
  public  var imports: Set<TemplatePrepend> {
      get { return underlyingImports }
      set(value) { underlyingImports = value }
  }
  public  var underlyingImports: Set<TemplatePrepend>!


  // MARK: - <init> - parameters

  public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryBuilderSignPostThrowableError: Error?
  public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryBuilderSignPostReceivedArguments: (productName: (String), swiftPackageDependencies: (DependencyProtocol), swiftPackageDump: (DumpProtocol), sourceryBuilder: (SourceryBuilderProtocol), signPost: (SignPostProtocol))?

  // MARK: - <init> - closure mocks

  public var initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryBuilderSignPostClosure: ((String, DependencyProtocol, DumpProtocol, SourceryBuilderProtocol, SignPostProtocol) throws  -> Void)? = nil


  // MARK: - <init> - initializer mocked

  public required init(      productName: String,      swiftPackageDependencies: DependencyProtocol,      swiftPackageDump: DumpProtocol,      sourceryBuilder: SourceryBuilderProtocol,      signPost: SignPostProtocol    ) throws {
      initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryBuilderSignPostReceivedArguments = (productName: productName, swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, sourceryBuilder: sourceryBuilder, signPost: signPost)
     try? initProductNameSwiftPackageDependenciesSwiftPackageDumpSourceryBuilderSignPostClosure?(productName, swiftPackageDependencies, swiftPackageDump, sourceryBuilder, signPost)
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

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - SourceryWorkerProtocolMock

open class SourceryWorkerProtocolMock: SourceryWorkerProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var sourceryYMLFile: FileProtocol {
      get { return underlyingSourceryYMLFile }
      set(value) { underlyingSourceryYMLFile = value }
  }
  public  var underlyingSourceryYMLFile: FileProtocol!


  // MARK: - <init> - parameters

  public var initSourceryTerminalSignPostQueueReceivedArguments: (sourcery: (SourceryProtocol), terminal: (TerminalProtocol), signPost: (SignPostProtocol), queue: (HighwayDispatchProtocol))?

  // MARK: - <init> - closure mocks

  public var initSourceryTerminalSignPostQueueClosure: ((SourceryProtocol, TerminalProtocol, SignPostProtocol, HighwayDispatchProtocol)  -> Void)? = nil


  // MARK: - <init> - initializer mocked

  public required init(      sourcery: SourceryProtocol,      terminal: TerminalProtocol,      signPost: SignPostProtocol,      queue: HighwayDispatchProtocol    ) {
      initSourceryTerminalSignPostQueueReceivedArguments = (sourcery: sourcery, terminal: terminal, signPost: signPost, queue: queue)
    initSourceryTerminalSignPostQueueClosure?(sourcery, terminal, signPost, queue)
  }


  // MARK: - <attempt> - parameters

  public var attemptInCallsCount = 0
  public var attemptInCalled: Bool {
    return attemptInCallsCount > 0
  }
  public var attemptInReceivedArguments: (folder: (FolderProtocol), async: ((@escaping SourceryWorker.SyncOutput) -> Void))?

  // MARK: - <attempt> - closure mocks

  public var attemptInClosure: ((FolderProtocol, @escaping (@escaping SourceryWorker.SyncOutput) -> Void)  -> Void)? = nil



  // MARK: - <attempt> - method mocked

  open func attempt(in folder: FolderProtocol, _ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) {

      attemptInCallsCount += 1
      attemptInReceivedArguments = (folder: folder, async: async)

      // <attempt> - Void return mock implementation

        attemptInClosure?(folder, async)

  }
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
