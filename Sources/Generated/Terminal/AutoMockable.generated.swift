import Arguments
import Foundation
import SignPost
import Terminal
import ZFile
import ZFileMock


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
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

              // You should implement Arguments

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

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - DependencyServiceProtocolMock

open class DependencyServiceProtocolMock: DependencyServiceProtocol {

    public init() {}



  // MARK: - <generateDependency> - parameters

  public var generateDependencyThrowableError: Error?
  public var generateDependencyCallsCount = 0
  public var generateDependencyCalled: Bool {
    return generateDependencyCallsCount > 0
  }
  public var generateDependencyReturnValue: DependencyProtocol?

  // MARK: - <generateDependency> - closure mocks

  public var generateDependencyClosure: (() throws  -> DependencyProtocol)? = nil



  // MARK: - <generateDependency> - method mocked

  open func generateDependency() throws -> DependencyProtocol {


      // <generateDependency> - Throwable method implementation

    if let error = generateDependencyThrowableError {
        throw error
    }

      generateDependencyCallsCount += 1

      // <generateDependency> - Return Value mock implementation

      guard let closureReturn = generateDependencyClosure else {
          guard let returnValue = generateDependencyReturnValue else {
              let message = "No returnValue implemented for generateDependencyClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement DependencyProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - DumpServiceProtocolMock

open class DumpServiceProtocolMock: DumpServiceProtocol {

    public init() {}



  // MARK: - <generateDump> - parameters

  public var generateDumpThrowableError: Error?
  public var generateDumpCallsCount = 0
  public var generateDumpCalled: Bool {
    return generateDumpCallsCount > 0
  }
  public var generateDumpReturnValue: DumpProtocol?

  // MARK: - <generateDump> - closure mocks

  public var generateDumpClosure: (() throws  -> DumpProtocol)? = nil



  // MARK: - <generateDump> - method mocked

  open func generateDump() throws -> DumpProtocol {


      // <generateDump> - Throwable method implementation

    if let error = generateDumpThrowableError {
        throw error
    }

      generateDumpCallsCount += 1

      // <generateDump> - Return Value mock implementation

      guard let closureReturn = generateDumpClosure else {
          guard let returnValue = generateDumpReturnValue else {
              let message = "No returnValue implemented for generateDumpClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement DumpProtocol

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

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - PathEnvironmentParserProtocolMock

open class PathEnvironmentParserProtocolMock: PathEnvironmentParserProtocol {

    public init() {}

  public var urls: [FolderProtocol] = []

}


// MARK: - ProcessProtocolMock

open class ProcessProtocolMock: ProcessProtocol {

    public init() {}

  public var standardInput: Any?
  public var standardOutput: Any?
  public var standardError: Any?
  public  var terminationStatus: Int32 {
      get { return underlyingTerminationStatus }
      set(value) { underlyingTerminationStatus = value }
  }
  public  var underlyingTerminationStatus: Int32!
  public var arguments: [String]?
  public  var currentDirectoryPath: String {
      get { return underlyingCurrentDirectoryPath }
      set(value) { underlyingCurrentDirectoryPath = value }
  }
  public  var underlyingCurrentDirectoryPath: String = "AutoMockable filled value"
  public  var isRunning: Bool {
      get { return underlyingIsRunning }
      set(value) { underlyingIsRunning = value }
  }
  public  var underlyingIsRunning: Bool = false
  public var terminationHandler: ((Process) -> Void)?


  // MARK: - <resume> - parameters

  public var resumeCallsCount = 0
  public var resumeCalled: Bool {
    return resumeCallsCount > 0
  }
  public var resumeReturnValue: Bool?

  // MARK: - <resume> - closure mocks

  public var resumeClosure: (()  -> Bool)? = nil



  // MARK: - <resume> - method mocked

  open func resume() -> Bool {

      resumeCallsCount += 1

      // <resume> - Return Value mock implementation

      guard let closureReturn = resumeClosure else {
          guard let returnValue = resumeReturnValue else {
              let message = "No returnValue implemented for resumeClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement Bool

              print("❌ \(error)")

              fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
          }
          return returnValue
      }

      return closureReturn()
  }

  // MARK: - <_run> - parameters

  public var _RunThrowableError: Error?
  public var _RunCallsCount = 0
  public var _RunCalled: Bool {
    return _RunCallsCount > 0
  }

  // MARK: - <_run> - closure mocks

  public var _RunClosure: (() throws  -> Void)? = nil



  // MARK: - <_run> - method mocked

  open func _run() throws {


      // <_run> - Throwable method implementation

    if let error = _RunThrowableError {
        throw error
    }

      _RunCallsCount += 1

      // <_run> - Void return mock implementation

        try _RunClosure?()

  }

  // MARK: - <waitUntilExit> - parameters

  public var waitUntilExitCallsCount = 0
  public var waitUntilExitCalled: Bool {
    return waitUntilExitCallsCount > 0
  }

  // MARK: - <waitUntilExit> - closure mocks

  public var waitUntilExitClosure: (()  -> Void)? = nil



  // MARK: - <waitUntilExit> - method mocked

  open func waitUntilExit() {

      waitUntilExitCallsCount += 1

      // <waitUntilExit> - Void return mock implementation

        waitUntilExitClosure?()

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


// MARK: - SystemProtocolMock

open class SystemProtocolMock: SystemProtocol {

    public init() {}

  public static var shared: SystemProtocol {
      get { return underlyingShared }
      set(value) { underlyingShared = value }
  }
  public static var underlyingShared: SystemProtocol!
  public static var brewPath: String {
      get { return underlyingBrewPath }
      set(value) { underlyingBrewPath = value }
  }
  public static var underlyingBrewPath: String = "AutoMockable filled value"
  public static var jazzyPath: String {
      get { return underlyingJazzyPath }
      set(value) { underlyingJazzyPath = value }
  }
  public static var underlyingJazzyPath: String = "AutoMockable filled value"
  public  var pathEnvironmentParser: PathEnvironmentParserProtocol {
      get { return underlyingPathEnvironmentParser }
      set(value) { underlyingPathEnvironmentParser = value }
  }
  public  var underlyingPathEnvironmentParser: PathEnvironmentParserProtocol!
  public  var fileSystem: FileSystemProtocol {
      get { return underlyingFileSystem }
      set(value) { underlyingFileSystem = value }
  }
  public  var underlyingFileSystem: FileSystemProtocol!


  // MARK: - <rbenvProcess> - parameters

  public var rbenvProcessInThrowableError: Error?
  public var rbenvProcessInCallsCount = 0
  public var rbenvProcessInCalled: Bool {
    return rbenvProcessInCallsCount > 0
  }
  public var rbenvProcessInReceivedFolder: FolderProtocol?
  public var rbenvProcessInReturnValue: ProcessProtocol?

  // MARK: - <rbenvProcess> - closure mocks

  public var rbenvProcessInClosure: ((FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <rbenvProcess> - method mocked

  open func rbenvProcess(in folder: FolderProtocol) throws -> ProcessProtocol {


      // <rbenvProcess> - Throwable method implementation

    if let error = rbenvProcessInThrowableError {
        throw error
    }

      rbenvProcessInCallsCount += 1
      rbenvProcessInReceivedFolder = folder

      // <rbenvProcess> - Return Value mock implementation

      guard let closureReturn = rbenvProcessInClosure else {
          guard let returnValue = rbenvProcessInReturnValue else {
              let message = "No returnValue implemented for rbenvProcessInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(folder)
  }

  // MARK: - <gemProcess> - parameters

  public var gemProcessNameInThrowableError: Error?
  public var gemProcessNameInCallsCount = 0
  public var gemProcessNameInCalled: Bool {
    return gemProcessNameInCallsCount > 0
  }
  public var gemProcessNameInReceivedArguments: (name: (String), folder: (FolderProtocol))?
  public var gemProcessNameInReturnValue: ProcessProtocol?

  // MARK: - <gemProcess> - closure mocks

  public var gemProcessNameInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <gemProcess> - method mocked

  open func gemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <gemProcess> - Throwable method implementation

    if let error = gemProcessNameInThrowableError {
        throw error
    }

      gemProcessNameInCallsCount += 1
      gemProcessNameInReceivedArguments = (name: name, folder: folder)

      // <gemProcess> - Return Value mock implementation

      guard let closureReturn = gemProcessNameInClosure else {
          guard let returnValue = gemProcessNameInReturnValue else {
              let message = "No returnValue implemented for gemProcessNameInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(name, folder)
  }

  // MARK: - <rbenvWhichProcess> - parameters

  public var rbenvWhichProcessGemNameInThrowableError: Error?
  public var rbenvWhichProcessGemNameInCallsCount = 0
  public var rbenvWhichProcessGemNameInCalled: Bool {
    return rbenvWhichProcessGemNameInCallsCount > 0
  }
  public var rbenvWhichProcessGemNameInReceivedArguments: (gemName: (String), folder: (FolderProtocol))?
  public var rbenvWhichProcessGemNameInReturnValue: ProcessProtocol?

  // MARK: - <rbenvWhichProcess> - closure mocks

  public var rbenvWhichProcessGemNameInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <rbenvWhichProcess> - method mocked

  open func rbenvWhichProcess(gemName: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <rbenvWhichProcess> - Throwable method implementation

    if let error = rbenvWhichProcessGemNameInThrowableError {
        throw error
    }

      rbenvWhichProcessGemNameInCallsCount += 1
      rbenvWhichProcessGemNameInReceivedArguments = (gemName: gemName, folder: folder)

      // <rbenvWhichProcess> - Return Value mock implementation

      guard let closureReturn = rbenvWhichProcessGemNameInClosure else {
          guard let returnValue = rbenvWhichProcessGemNameInReturnValue else {
              let message = "No returnValue implemented for rbenvWhichProcessGemNameInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(gemName, folder)
  }

  // MARK: - <installOrFindGemProcess> - parameters

  public var installOrFindGemProcessNameInThrowableError: Error?
  public var installOrFindGemProcessNameInCallsCount = 0
  public var installOrFindGemProcessNameInCalled: Bool {
    return installOrFindGemProcessNameInCallsCount > 0
  }
  public var installOrFindGemProcessNameInReceivedArguments: (name: (String), folder: (FolderProtocol))?
  public var installOrFindGemProcessNameInReturnValue: ProcessProtocol?

  // MARK: - <installOrFindGemProcess> - closure mocks

  public var installOrFindGemProcessNameInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <installOrFindGemProcess> - method mocked

  open func installOrFindGemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <installOrFindGemProcess> - Throwable method implementation

    if let error = installOrFindGemProcessNameInThrowableError {
        throw error
    }

      installOrFindGemProcessNameInCallsCount += 1
      installOrFindGemProcessNameInReceivedArguments = (name: name, folder: folder)

      // <installOrFindGemProcess> - Return Value mock implementation

      guard let closureReturn = installOrFindGemProcessNameInClosure else {
          guard let returnValue = installOrFindGemProcessNameInReturnValue else {
              let message = "No returnValue implemented for installOrFindGemProcessNameInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(name, folder)
  }

  // MARK: - <processFromBrew> - parameters

  public var processFromBrewFormulaInThrowableError: Error?
  public var processFromBrewFormulaInCallsCount = 0
  public var processFromBrewFormulaInCalled: Bool {
    return processFromBrewFormulaInCallsCount > 0
  }
  public var processFromBrewFormulaInReceivedArguments: (formula: (String), folder: (FolderProtocol))?
  public var processFromBrewFormulaInReturnValue: ProcessProtocol?

  // MARK: - <processFromBrew> - closure mocks

  public var processFromBrewFormulaInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <processFromBrew> - method mocked

  open func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <processFromBrew> - Throwable method implementation

    if let error = processFromBrewFormulaInThrowableError {
        throw error
    }

      processFromBrewFormulaInCallsCount += 1
      processFromBrewFormulaInReceivedArguments = (formula: formula, folder: folder)

      // <processFromBrew> - Return Value mock implementation

      guard let closureReturn = processFromBrewFormulaInClosure else {
          guard let returnValue = processFromBrewFormulaInReturnValue else {
              let message = "No returnValue implemented for processFromBrewFormulaInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(formula, folder)
  }

  // MARK: - <installOrGetProcessFromBrew> - parameters

  public var installOrGetProcessFromBrewFormulaInThrowableError: Error?
  public var installOrGetProcessFromBrewFormulaInCallsCount = 0
  public var installOrGetProcessFromBrewFormulaInCalled: Bool {
    return installOrGetProcessFromBrewFormulaInCallsCount > 0
  }
  public var installOrGetProcessFromBrewFormulaInReceivedArguments: (formula: (String), folder: (FolderProtocol))?
  public var installOrGetProcessFromBrewFormulaInReturnValue: ProcessProtocol?

  // MARK: - <installOrGetProcessFromBrew> - closure mocks

  public var installOrGetProcessFromBrewFormulaInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <installOrGetProcessFromBrew> - method mocked

  open func installOrGetProcessFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <installOrGetProcessFromBrew> - Throwable method implementation

    if let error = installOrGetProcessFromBrewFormulaInThrowableError {
        throw error
    }

      installOrGetProcessFromBrewFormulaInCallsCount += 1
      installOrGetProcessFromBrewFormulaInReceivedArguments = (formula: formula, folder: folder)

      // <installOrGetProcessFromBrew> - Return Value mock implementation

      guard let closureReturn = installOrGetProcessFromBrewFormulaInClosure else {
          guard let returnValue = installOrGetProcessFromBrewFormulaInReturnValue else {
              let message = "No returnValue implemented for installOrGetProcessFromBrewFormulaInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(formula, folder)
  }

  // MARK: - <brewListProcess> - parameters

  public var brewListProcessForInThrowableError: Error?
  public var brewListProcessForInCallsCount = 0
  public var brewListProcessForInCalled: Bool {
    return brewListProcessForInCallsCount > 0
  }
  public var brewListProcessForInReceivedArguments: (formula: (String), folder: (FolderProtocol))?
  public var brewListProcessForInReturnValue: ProcessProtocol?

  // MARK: - <brewListProcess> - closure mocks

  public var brewListProcessForInClosure: ((String, FolderProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <brewListProcess> - method mocked

  open func brewListProcess(for formula: String, in folder: FolderProtocol) throws -> ProcessProtocol {


      // <brewListProcess> - Throwable method implementation

    if let error = brewListProcessForInThrowableError {
        throw error
    }

      brewListProcessForInCallsCount += 1
      brewListProcessForInReceivedArguments = (formula: formula, folder: folder)

      // <brewListProcess> - Return Value mock implementation

      guard let closureReturn = brewListProcessForInClosure else {
          guard let returnValue = brewListProcessForInReturnValue else {
              let message = "No returnValue implemented for brewListProcessForInClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(formula, folder)
  }

  // MARK: - <process> - parameters

  public var processThrowableError: Error?
  public var processCallsCount = 0
  public var processCalled: Bool {
    return processCallsCount > 0
  }
  public var processReceivedExecutableName: String?
  public var processReturnValue: ProcessProtocol?

  // MARK: - <process> - closure mocks

  public var processClosure: ((String) throws  -> ProcessProtocol)? = nil



  // MARK: - <process> - method mocked

  open func process(_ executableName: String) throws -> ProcessProtocol {


      // <process> - Throwable method implementation

    if let error = processThrowableError {
        throw error
    }

      processCallsCount += 1
      processReceivedExecutableName = executableName

      // <process> - Return Value mock implementation

      guard let closureReturn = processClosure else {
          guard let returnValue = processReturnValue else {
              let message = "No returnValue implemented for processClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(executableName)
  }

  // MARK: - <process> - parameters

  public var processCurrentFolderExecutablePathThrowableError: Error?
  public var processCurrentFolderExecutablePathCallsCount = 0
  public var processCurrentFolderExecutablePathCalled: Bool {
    return processCurrentFolderExecutablePathCallsCount > 0
  }
  public var processCurrentFolderExecutablePathReceivedArguments: (currentFolder: (FolderProtocol), executablePath: (String))?
  public var processCurrentFolderExecutablePathReturnValue: ProcessProtocol?

  // MARK: - <process> - closure mocks

  public var processCurrentFolderExecutablePathClosure: ((FolderProtocol, String) throws  -> ProcessProtocol)? = nil



  // MARK: - <process> - method mocked

  open func process(currentFolder: FolderProtocol, executablePath: String) throws -> ProcessProtocol {


      // <process> - Throwable method implementation

    if let error = processCurrentFolderExecutablePathThrowableError {
        throw error
    }

      processCurrentFolderExecutablePathCallsCount += 1
      processCurrentFolderExecutablePathReceivedArguments = (currentFolder: currentFolder, executablePath: executablePath)

      // <process> - Return Value mock implementation

      guard let closureReturn = processCurrentFolderExecutablePathClosure else {
          guard let returnValue = processCurrentFolderExecutablePathReturnValue else {
              let message = "No returnValue implemented for processCurrentFolderExecutablePathClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(currentFolder, executablePath)
  }

  // MARK: - <process> - parameters

  public var processCurrentFolderExecutableFileThrowableError: Error?
  public var processCurrentFolderExecutableFileCallsCount = 0
  public var processCurrentFolderExecutableFileCalled: Bool {
    return processCurrentFolderExecutableFileCallsCount > 0
  }
  public var processCurrentFolderExecutableFileReceivedArguments: (currentFolder: (FolderProtocol), executableFile: (FileProtocol))?
  public var processCurrentFolderExecutableFileReturnValue: ProcessProtocol?

  // MARK: - <process> - closure mocks

  public var processCurrentFolderExecutableFileClosure: ((FolderProtocol, FileProtocol) throws  -> ProcessProtocol)? = nil



  // MARK: - <process> - method mocked

  open func process(currentFolder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol {


      // <process> - Throwable method implementation

    if let error = processCurrentFolderExecutableFileThrowableError {
        throw error
    }

      processCurrentFolderExecutableFileCallsCount += 1
      processCurrentFolderExecutableFileReceivedArguments = (currentFolder: currentFolder, executableFile: executableFile)

      // <process> - Return Value mock implementation

      guard let closureReturn = processCurrentFolderExecutableFileClosure else {
          guard let returnValue = processCurrentFolderExecutableFileReturnValue else {
              let message = "No returnValue implemented for processCurrentFolderExecutableFileClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement ProcessProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(currentFolder, executableFile)
  }

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

              // You should implement FileProtocol

              throw error
          }
          return returnValue
      }

      return try closureReturn(executableName)
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
  public var capturedOutputData: Data?
  public var readOutputString: String?
  public var trimmedOutput: String?
  public var capturedOutputString: String?
  public  var toProcess: ProcessProtocol {
      get { return underlyingToProcess }
      set(value) { underlyingToProcess = value }
  }
  public  var underlyingToProcess: ProcessProtocol!
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
}


// MARK: - TerminalProtocolMock

open class TerminalProtocolMock: TerminalProtocol {

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

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn(task)
  }

  // MARK: - <runExecutable> - parameters

  public var runExecutableThrowableError: Error?
  public var runExecutableCallsCount = 0
  public var runExecutableCalled: Bool {
    return runExecutableCallsCount > 0
  }
  public var runExecutableReceivedExecutable: ExecutableProtocol?
  public var runExecutableReturnValue: [String]?

  // MARK: - <runExecutable> - closure mocks

  public var runExecutableClosure: ((ExecutableProtocol) throws  -> [String])? = nil



  // MARK: - <runExecutable> - method mocked

  open func runExecutable(_ executable: ExecutableProtocol) throws -> [String] {


      // <runExecutable> - Throwable method implementation

    if let error = runExecutableThrowableError {
        throw error
    }

      runExecutableCallsCount += 1
      runExecutableReceivedExecutable = executable

      // <runExecutable> - Return Value mock implementation

      guard let closureReturn = runExecutableClosure else {
          guard let returnValue = runExecutableReturnValue else {
              let message = "No returnValue implemented for runExecutableClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn(executable)
  }

  // MARK: - <runProcess> - parameters

  public var runProcessThrowableError: Error?
  public var runProcessCallsCount = 0
  public var runProcessCalled: Bool {
    return runProcessCallsCount > 0
  }
  public var runProcessReceivedProcessTask: ProcessProtocol?
  public var runProcessReturnValue: [String]?

  // MARK: - <runProcess> - closure mocks

  public var runProcessClosure: ((ProcessProtocol) throws  -> [String])? = nil



  // MARK: - <runProcess> - method mocked

  open func runProcess(_ processTask: ProcessProtocol) throws -> [String] {


      // <runProcess> - Throwable method implementation

    if let error = runProcessThrowableError {
        throw error
    }

      runProcessCallsCount += 1
      runProcessReceivedProcessTask = processTask

      // <runProcess> - Return Value mock implementation

      guard let closureReturn = runProcessClosure else {
          guard let returnValue = runProcessReturnValue else {
              let message = "No returnValue implemented for runProcessClosure"
              let error = SourceryMockError.implementErrorCaseFor(message)

              // You should implement [String]

              throw error
          }
          return returnValue
      }

      return try closureReturn(processTask)
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
