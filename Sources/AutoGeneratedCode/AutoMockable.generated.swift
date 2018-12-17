import SourceryWorker


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable identifier_name
// swiftlint:disable large_tuple
// swiftlint:disable file_length

















// MARK: - ArchiveOptionsProtocolMock

open class ArchiveOptionsProtocolMock: ArchiveOptionsProtocol {

    public init() {}

  public  var scheme: String {
      get { return underlyingScheme }
      set(value) { underlyingScheme = value }
  }
  public  var underlyingScheme: String = "AutoMockable filled value"
  public  var project: String {
      get { return underlyingProject }
      set(value) { underlyingProject = value }
  }
  public  var underlyingProject: String = "AutoMockable filled value"
  public  var destination: DestinationProtocol {
      get { return underlyingDestination }
      set(value) { underlyingDestination = value }
  }
  public  var underlyingDestination: DestinationProtocol!
  public  var archivePath: String {
      get { return underlyingArchivePath }
      set(value) { underlyingArchivePath = value }
  }
  public  var underlyingArchivePath: String = "AutoMockable filled value"

}


// MARK: - ArchivePlistProtocolMock

open class ArchivePlistProtocolMock: ArchivePlistProtocol {

    public init() {}

  public  var applicationProperties: String {
      get { return underlyingApplicationProperties }
      set(value) { underlyingApplicationProperties = value }
  }
  public  var underlyingApplicationProperties: String = "AutoMockable filled value"
  public  var applicationPath: String {
      get { return underlyingApplicationPath }
      set(value) { underlyingApplicationPath = value }
  }
  public  var underlyingApplicationPath: String = "AutoMockable filled value"

}


// MARK: - ArchiveProtocolMock

open class ArchiveProtocolMock: ArchiveProtocol {

    public init() {}

  public  var archiveFolder: FolderProtocol {
      get { return underlyingArchiveFolder }
      set(value) { underlyingArchiveFolder = value }
  }
  public  var underlyingArchiveFolder: FolderProtocol!
  public  var appFolder: FolderProtocol {
      get { return underlyingAppFolder }
      set(value) { underlyingAppFolder = value }
  }
  public  var underlyingAppFolder: FolderProtocol!
  public  var plist: ArchivePlistProtocol {
      get { return underlyingPlist }
      set(value) { underlyingPlist = value }
  }
  public  var underlyingPlist: ArchivePlistProtocol!

}


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

  public var argumentsClosure: (() throws -> Arguments)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    arguments
                    but this case(s) is(are) not implemented in
                    ArgumentExecutableProtocol for method argumentsClosure.
                """
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

  public var executableFileClosure: (() throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableFile
                    but this case(s) is(are) not implemented in
                    ExecutableProtocol for method executableFileClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - ArgumentsWorkerProtocolMock

open class ArgumentsWorkerProtocolMock: ArgumentsWorkerProtocol {

    public init() {}

  public var workers: [Worker] = []

}


// MARK: - AutomateSourceryWorkerProtocolMock

open class AutomateSourceryWorkerProtocolMock: AutomateSourceryWorkerProtocol {

    public init() {}



  // MARK: - <attempt> - parameters

  public var attemptThrowableError: Error?
  public var attemptCallsCount = 0
  public var attemptCalled: Bool {
    return attemptCallsCount > 0
  }
  public var attemptReturnValue: [String]?

  // MARK: - <attempt> - closure mocks

  public var attemptClosure: (() throws -> [String])? = nil



  // MARK: - <attempt> - method mocked

  open func attempt() throws -> [String] {


      // <attempt> - Throwable method implementation

    if let error = attemptThrowableError {
        throw error
    }

      attemptCallsCount += 1

      // <attempt> - Return Value mock implementation

      guard let closureReturn = attemptClosure else {
          guard let returnValue = attemptReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    attempt
                    but this case(s) is(are) not implemented in
                    AutomateSourceryWorkerProtocol for method attemptClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - DeliverProtocolMock

open class DeliverProtocolMock: DeliverProtocol {

    public init() {}



  // MARK: - <now> - parameters

  public var nowWithThrowableError: Error?
  public var nowWithCallsCount = 0
  public var nowWithCalled: Bool {
    return nowWithCallsCount > 0
  }
  public var nowWithReceivedOptions: Deliver.Options?
  public var nowWithReturnValue: Bool?

  // MARK: - <now> - closure mocks

  public var nowWithClosure: ((Deliver.Options) throws -> Bool)? = nil



  // MARK: - <now> - method mocked

  open func now(with options: Deliver.Options) throws -> Bool {


      // <now> - Throwable method implementation

    if let error = nowWithThrowableError {
        throw error
    }

      nowWithCallsCount += 1
      nowWithReceivedOptions = options

      // <now> - Return Value mock implementation

      guard let closureReturn = nowWithClosure else {
          guard let returnValue = nowWithReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    nowWith
                    but this case(s) is(are) not implemented in
                    DeliverProtocol for method nowWithClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(options)
  }
}


// MARK: - DestinationFactoryProtocolMock

open class DestinationFactoryProtocolMock: DestinationFactoryProtocol {

    public init() {}



  // MARK: - <macOS> - parameters

  public var macOSArchitectureCallsCount = 0
  public var macOSArchitectureCalled: Bool {
    return macOSArchitectureCallsCount > 0
  }
  public var macOSArchitectureReceivedArchitecture: Destination.Architecture?
  public var macOSArchitectureReturnValue: Destination?

  // MARK: - <macOS> - closure mocks

  public var macOSArchitectureClosure: ((Destination.Architecture) -> Destination)? = nil



  // MARK: - <macOS> - method mocked

  open func macOS(architecture: Destination.Architecture) -> Destination {

      macOSArchitectureCallsCount += 1
      macOSArchitectureReceivedArchitecture = architecture

      // <macOS> - Return Value mock implementation

      guard let closureReturn = macOSArchitectureClosure else {
          guard let returnValue = macOSArchitectureReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    macOSArchitecture
                    but this case(s) is(are) not implemented in
                    DestinationFactoryProtocol for method macOSArchitectureClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
              os_log("🧙‍♂️ 🔥 %@", type: .error, "\(error)")

              return macOSArchitectureReturnValue!
          }
          return returnValue
      }

      return closureReturn(architecture)
  }

  // MARK: - <device> - parameters

  public var deviceNameIsGenericIdCallsCount = 0
  public var deviceNameIsGenericIdCalled: Bool {
    return deviceNameIsGenericIdCallsCount > 0
  }
  public var deviceNameIsGenericIdReceivedArguments: (device: (Destination.Device), name: (String)?, isGeneric: (Bool), id: (String)?)?
  public var deviceNameIsGenericIdReturnValue: Destination?

  // MARK: - <device> - closure mocks

  public var deviceNameIsGenericIdClosure: ((Destination.Device, String?, Bool, String?) -> Destination)? = nil



  // MARK: - <device> - method mocked

  open func device(_ device: Destination.Device, name: String?, isGeneric: Bool, id: String?) -> Destination {

      deviceNameIsGenericIdCallsCount += 1
      deviceNameIsGenericIdReceivedArguments = (device: device, name: name, isGeneric: isGeneric, id: id)

      // <device> - Return Value mock implementation

      guard let closureReturn = deviceNameIsGenericIdClosure else {
          guard let returnValue = deviceNameIsGenericIdReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    deviceNameIsGenericId
                    but this case(s) is(are) not implemented in
                    DestinationFactoryProtocol for method deviceNameIsGenericIdClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
              os_log("🧙‍♂️ 🔥 %@", type: .error, "\(error)")

              return deviceNameIsGenericIdReturnValue!
          }
          return returnValue
      }

      return closureReturn(device, name, isGeneric, id)
  }

  // MARK: - <simulator> - parameters

  public var simulatorNameOsIdCallsCount = 0
  public var simulatorNameOsIdCalled: Bool {
    return simulatorNameOsIdCallsCount > 0
  }
  public var simulatorNameOsIdReceivedArguments: (simulator: (Destination.Simulator), name: (String), os: (Destination.OS), id: (String)?)?
  public var simulatorNameOsIdReturnValue: Destination?

  // MARK: - <simulator> - closure mocks

  public var simulatorNameOsIdClosure: ((Destination.Simulator, String, Destination.OS, String?) -> Destination)? = nil



  // MARK: - <simulator> - method mocked

  open func simulator(_ simulator: Destination.Simulator, name: String, os: Destination.OS, id: String?) -> Destination {

      simulatorNameOsIdCallsCount += 1
      simulatorNameOsIdReceivedArguments = (simulator: simulator, name: name, os: os, id: id)

      // <simulator> - Return Value mock implementation

      guard let closureReturn = simulatorNameOsIdClosure else {
          guard let returnValue = simulatorNameOsIdReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    simulatorNameOsId
                    but this case(s) is(are) not implemented in
                    DestinationFactoryProtocol for method simulatorNameOsIdClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
              os_log("🧙‍♂️ 🔥 %@", type: .error, "\(error)")

              return simulatorNameOsIdReturnValue!
          }
          return returnValue
      }

      return closureReturn(simulator, name, os, id)
  }
}


// MARK: - DestinationProtocolMock

open class DestinationProtocolMock: DestinationProtocol {

    public init() {}

  public var raw: [String: String] = [:]
  public  var asString: String {
      get { return underlyingAsString }
      set(value) { underlyingAsString = value }
  }
  public  var underlyingAsString: String = "AutoMockable filled value"

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

  public var executableFileClosure: (() throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableFile
                    but this case(s) is(are) not implemented in
                    ExecutableProtocol for method executableFileClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


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

  public var executableWithClosure: ((String) throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableWith
                    but this case(s) is(are) not implemented in
                    ExecutableProviderProtocol for method executableWithClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(executableName)
  }
}


// MARK: - ExportArchiveOptionsProtocolMock

open class ExportArchiveOptionsProtocolMock: ExportArchiveOptionsProtocol {

    public init() {}

  public  var archivePath: FolderProtocol {
      get { return underlyingArchivePath }
      set(value) { underlyingArchivePath = value }
  }
  public  var underlyingArchivePath: FolderProtocol!
  public  var exportPath: String {
      get { return underlyingExportPath }
      set(value) { underlyingExportPath = value }
  }
  public  var underlyingExportPath: String = "AutoMockable filled value"


  // MARK: - <encode> - parameters

  public var encodeToThrowableError: Error?
  public var encodeToCallsCount = 0
  public var encodeToCalled: Bool {
    return encodeToCallsCount > 0
  }
  public var encodeToReceivedEncoder: Encoder?

  // MARK: - <encode> - closure mocks

  public var encodeToClosure: ((Encoder) throws -> Void)? = nil



  // MARK: - <encode> - method mocked

  open func encode(to encoder: Encoder) throws {


      // <encode> - Throwable method implementation

    if let error = encodeToThrowableError {
        throw error
    }

      encodeToCallsCount += 1
      encodeToReceivedEncoder = encoder

      // <encode> - Void return mock implementation

      try encodeToClosure?(encoder)

  }
}


// MARK: - ExportProtocolMock

open class ExportProtocolMock: ExportProtocol {

    public init() {}

  public  var folder: FolderProtocol {
      get { return underlyingFolder }
      set(value) { underlyingFolder = value }
  }
  public  var underlyingFolder: FolderProtocol!
  public  var ipa: FileProtocol {
      get { return underlyingIpa }
      set(value) { underlyingIpa = value }
  }
  public  var underlyingIpa: FileProtocol!

}


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

  public var addAllAtClosure: ((FolderProtocol) throws -> Void)? = nil



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

  public var commitAtMessageClosure: ((FolderProtocol, String) throws -> Void)? = nil



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

  public var pushToMasterAtClosure: ((FolderProtocol) throws -> Void)? = nil



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

  public var pushTagsToMasterAtClosure: ((FolderProtocol) throws -> Void)? = nil



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

  public var pullAtClosure: ((FolderProtocol) throws -> Void)? = nil



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

  public var currentTagAtClosure: ((FolderProtocol) throws -> String)? = nil



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

  public var cloneWithClosure: ((CloneOptions) throws -> Void)? = nil



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


// MARK: - ImportProtocolMock

open class ImportProtocolMock: ImportProtocol {

    public init() {}

  public  var name: Set<String> {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: Set<String>!
  public  var template: String {
      get { return underlyingTemplate }
      set(value) { underlyingTemplate = value }
  }
  public  var underlyingTemplate: String = "AutoMockable filled value"

}


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

  public var passwordMatchingClosure: ((Keychain.PasswordQuery) throws -> String)? = nil



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


// MARK: - SignPostProtocolMock

open class SignPostProtocolMock: SignPostProtocol {

    public init() {}

  public static var shared: SignPost {
      get { return underlyingShared }
      set(value) { underlyingShared = value }
  }
  public static var underlyingShared: SignPost!
  public  var verbose: Bool {
      get { return underlyingVerbose }
      set(value) { underlyingVerbose = value }
  }
  public  var underlyingVerbose: Bool = false


  // MARK: - <write> - parameters

  public var writeCallsCount = 0
  public var writeCalled: Bool {
    return writeCallsCount > 0
  }
  public var writeReceivedPrinter: Printer?

  // MARK: - <write> - closure mocks

  public var writeClosure: ((Printer) -> Void)? = nil



  // MARK: - <write> - method mocked

  open func write(_ printer: Printer) {

      writeCallsCount += 1
      writeReceivedPrinter = printer

      // <write> - Void return mock implementation

      writeClosure?(printer)

  }

  // MARK: - <write> - parameters

  public var writeCallsCount = 0
  public var writeCalled: Bool {
    return writeCallsCount > 0
  }
  public var writeReceivedPrintable: Printable?

  // MARK: - <write> - closure mocks

  public var writeClosure: ((Printable) -> Void)? = nil



  // MARK: - <write> - method mocked

  open func write(_ printable: Printable) {

      writeCallsCount += 1
      writeReceivedPrintable = printable

      // <write> - Void return mock implementation

      writeClosure?(printable)

  }

  // MARK: - <error> - parameters

  public var errorCallsCount = 0
  public var errorCalled: Bool {
    return errorCallsCount > 0
  }
  public var errorReceivedText: String?

  // MARK: - <error> - closure mocks

  public var errorClosure: ((String) -> Void)? = nil



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

  public var successClosure: ((String) -> Void)? = nil



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

  public var messageClosure: ((String) -> Void)? = nil



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

  public var verboseClosure: ((String) -> Void)? = nil



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

  public var printClosure: ((Printable) -> Void)? = nil



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

  public var verbosePrintClosure: ((Printable) -> Void)? = nil



  // MARK: - <verbosePrint> - method mocked

  open func verbosePrint(_ printable: Printable) {

      verbosePrintCallsCount += 1
      verbosePrintReceivedPrintable = printable

      // <verbosePrint> - Void return mock implementation

      verbosePrintClosure?(printable)

  }
}


// MARK: - SourceryExecutableFileProtocolMock

open class SourceryExecutableFileProtocolMock: SourceryExecutableFileProtocol {

    public init() {}


}


// MARK: - SourceryProtocolMock

open class SourceryProtocolMock: SourceryProtocol {

    public init() {}

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
  public  var imports: Set<Import> {
      get { return underlyingImports }
      set(value) { underlyingImports = value }
  }
  public  var underlyingImports: Set<Import>!


  // MARK: - <executableFile> - parameters

  public var executableFileThrowableError: Error?
  public var executableFileCallsCount = 0
  public var executableFileCalled: Bool {
    return executableFileCallsCount > 0
  }
  public var executableFileReturnValue: FileProtocol?

  // MARK: - <executableFile> - closure mocks

  public var executableFileClosure: (() throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableFile
                    but this case(s) is(are) not implemented in
                    ExecutableProtocol for method executableFileClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
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

  public var launchTaskWaitClosure: ((Task, Bool) throws -> Void)? = nil



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

  public var taskNamedClosure: ((String) throws -> Task)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    taskNamed
                    but this case(s) is(are) not implemented in
                    SystemProtocol for method taskNamedClosure.
                """
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

  public var executeClosure: ((Task) throws -> Bool)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    execute
                    but this case(s) is(are) not implemented in
                    SystemProtocol for method executeClosure.
                """
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

  public var launchWaitClosure: ((Task, Bool) throws -> Bool)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    launchWait
                    but this case(s) is(are) not implemented in
                    SystemProtocol for method launchWaitClosure.
                """
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
  public var environment: [String : String] = [:]
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

  public var enableReadableOutputDataCapturingClosure: (() -> Void)? = nil



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

  public var throwIfNotSuccessClosure: ((Swift.Error) throws -> Void)? = nil



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

  public var terminalTaskClosure: ((TerminalTask) throws -> [String])? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    terminalTask
                    but this case(s) is(are) not implemented in
                    TerminalWorkerProtocol for method terminalTaskClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(task)
  }
}


// MARK: - TestOptionsProtocolMock

open class TestOptionsProtocolMock: TestOptionsProtocol {

    public init() {}

  public  var scheme: String {
      get { return underlyingScheme }
      set(value) { underlyingScheme = value }
  }
  public  var underlyingScheme: String = "AutoMockable filled value"
  public  var project: String {
      get { return underlyingProject }
      set(value) { underlyingProject = value }
  }
  public  var underlyingProject: String = "AutoMockable filled value"
  public  var destination: DestinationProtocol {
      get { return underlyingDestination }
      set(value) { underlyingDestination = value }
  }
  public  var underlyingDestination: DestinationProtocol!
  public  var resultBundlePath: String {
      get { return underlyingResultBundlePath }
      set(value) { underlyingResultBundlePath = value }
  }
  public  var underlyingResultBundlePath: String = "AutoMockable filled value"
  public var derivedDataPath: FolderProtocol?


  // MARK: - <arguments> - parameters

  public var argumentsThrowableError: Error?
  public var argumentsCallsCount = 0
  public var argumentsCalled: Bool {
    return argumentsCallsCount > 0
  }
  public var argumentsReturnValue: Arguments?

  // MARK: - <arguments> - closure mocks

  public var argumentsClosure: (() throws -> Arguments)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    arguments
                    but this case(s) is(are) not implemented in
                    TestOptionsProtocol for method argumentsClosure.
                """
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

  public var executableFileClosure: (() throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableFile
                    but this case(s) is(are) not implemented in
                    TestOptionsProtocol for method executableFileClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }

  // MARK: - <arguments> - parameters

  public var argumentsThrowableError: Error?
  public var argumentsCallsCount = 0
  public var argumentsCalled: Bool {
    return argumentsCallsCount > 0
  }
  public var argumentsReturnValue: Arguments?

  // MARK: - <arguments> - closure mocks

  public var argumentsClosure: (() throws -> Arguments)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    arguments
                    but this case(s) is(are) not implemented in
                    ArgumentExecutableProtocol for method argumentsClosure.
                """
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

  public var executableFileClosure: (() throws -> FileProtocol)? = nil



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
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    executableFile
                    but this case(s) is(are) not implemented in
                    ExecutableProtocol for method executableFileClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn()
  }
}


// MARK: - XCBuildProtocolMock

open class XCBuildProtocolMock: XCBuildProtocol {

    public init() {}

  public  var system: SystemProtocol {
      get { return underlyingSystem }
      set(value) { underlyingSystem = value }
  }
  public  var underlyingSystem: SystemProtocol!
  public  var fileSystem: FileSystemProtocol {
      get { return underlyingFileSystem }
      set(value) { underlyingFileSystem = value }
  }
  public  var underlyingFileSystem: FileSystemProtocol!


  // MARK: - <archive> - parameters

  public var archiveUsingThrowableError: Error?
  public var archiveUsingCallsCount = 0
  public var archiveUsingCalled: Bool {
    return archiveUsingCallsCount > 0
  }
  public var archiveUsingReceivedOptions: ArchiveOptionsProtocol?
  public var archiveUsingReturnValue: ArchiveProtocol?

  // MARK: - <archive> - closure mocks

  public var archiveUsingClosure: ((ArchiveOptionsProtocol) throws -> ArchiveProtocol)? = nil



  // MARK: - <archive> - method mocked

  open func archive(using options: ArchiveOptionsProtocol) throws -> ArchiveProtocol {


      // <archive> - Throwable method implementation

    if let error = archiveUsingThrowableError {
        throw error
    }

      archiveUsingCallsCount += 1
      archiveUsingReceivedOptions = options

      // <archive> - Return Value mock implementation

      guard let closureReturn = archiveUsingClosure else {
          guard let returnValue = archiveUsingReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    archiveUsing
                    but this case(s) is(are) not implemented in
                    XCBuildProtocol for method archiveUsingClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(options)
  }

  // MARK: - <export> - parameters

  public var exportUsingThrowableError: Error?
  public var exportUsingCallsCount = 0
  public var exportUsingCalled: Bool {
    return exportUsingCallsCount > 0
  }
  public var exportUsingReceivedOptions: ExportArchiveOptionsProtocol?
  public var exportUsingReturnValue: ExportProtocol?

  // MARK: - <export> - closure mocks

  public var exportUsingClosure: ((ExportArchiveOptionsProtocol) throws -> ExportProtocol)? = nil



  // MARK: - <export> - method mocked

  open func export(using options: ExportArchiveOptionsProtocol) throws -> ExportProtocol {


      // <export> - Throwable method implementation

    if let error = exportUsingThrowableError {
        throw error
    }

      exportUsingCallsCount += 1
      exportUsingReceivedOptions = options

      // <export> - Return Value mock implementation

      guard let closureReturn = exportUsingClosure else {
          guard let returnValue = exportUsingReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    exportUsing
                    but this case(s) is(are) not implemented in
                    XCBuildProtocol for method exportUsingClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(options)
  }

  // MARK: - <buildAndTest> - parameters

  public var buildAndTestUsingThrowableError: Error?
  public var buildAndTestUsingCallsCount = 0
  public var buildAndTestUsingCalled: Bool {
    return buildAndTestUsingCallsCount > 0
  }
  public var buildAndTestUsingReceivedOptions: ArgumentExecutableProtocol?
  public var buildAndTestUsingReturnValue: TestReport?

  // MARK: - <buildAndTest> - closure mocks

  public var buildAndTestUsingClosure: ((ArgumentExecutableProtocol) throws -> TestReport)? = nil



  // MARK: - <buildAndTest> - method mocked

  open func buildAndTest(using options: ArgumentExecutableProtocol) throws -> TestReport {


      // <buildAndTest> - Throwable method implementation

    if let error = buildAndTestUsingThrowableError {
        throw error
    }

      buildAndTestUsingCallsCount += 1
      buildAndTestUsingReceivedOptions = options

      // <buildAndTest> - Return Value mock implementation

      guard let closureReturn = buildAndTestUsingClosure else {
          guard let returnValue = buildAndTestUsingReturnValue else {
              let message = """
                🧙‍♂️ 🔥asked to return a value for name parameters:
                    buildAndTestUsing
                    but this case(s) is(are) not implemented in
                    XCBuildProtocol for method buildAndTestUsingClosure.
                """
              let error = SourceryMockError.implementErrorCaseFor(message)
                 throw error
          }
          return returnValue
      }

      return try closureReturn(options)
  }
}


// MARK: - OBJECTIVE-C

