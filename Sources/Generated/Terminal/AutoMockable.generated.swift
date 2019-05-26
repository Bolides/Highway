import Errors
import Foundation
import HighwayDispatch
import Result
import SignPost
import Terminal
import ZFile

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - ArchiveOptionsProtocolMock

open class ArchiveOptionsProtocolMock: ArchiveOptionsProtocol
{
    public init() {}

    public var scheme: String
    {
        get { return underlyingScheme }
        set(value) { underlyingScheme = value }
    }

    public var underlyingScheme: String = "AutoMockable filled value"
    public var project: String
    {
        get { return underlyingProject }
        set(value) { underlyingProject = value }
    }

    public var underlyingProject: String = "AutoMockable filled value"
    public var destination: DestinationProtocol
    {
        get { return underlyingDestination }
        set(value) { underlyingDestination = value }
    }

    public var underlyingDestination: DestinationProtocol!
    public var archivePath: String
    {
        get { return underlyingArchivePath }
        set(value) { underlyingArchivePath = value }
    }

    public var underlyingArchivePath: String = "AutoMockable filled value"
}

// MARK: - ArchivePlistProtocolMock

open class ArchivePlistProtocolMock: ArchivePlistProtocol
{
    public init() {}

    public var applicationProperties: String
    {
        get { return underlyingApplicationProperties }
        set(value) { underlyingApplicationProperties = value }
    }

    public var underlyingApplicationProperties: String = "AutoMockable filled value"
    public var applicationPath: String
    {
        get { return underlyingApplicationPath }
        set(value) { underlyingApplicationPath = value }
    }

    public var underlyingApplicationPath: String = "AutoMockable filled value"
}

// MARK: - ArchiveProtocolMock

open class ArchiveProtocolMock: ArchiveProtocol
{
    public init() {}

    public var archiveFolder: FolderProtocol
    {
        get { return underlyingArchiveFolder }
        set(value) { underlyingArchiveFolder = value }
    }

    public var underlyingArchiveFolder: FolderProtocol!
    public var appFolder: FolderProtocol
    {
        get { return underlyingAppFolder }
        set(value) { underlyingAppFolder = value }
    }

    public var underlyingAppFolder: FolderProtocol!
    public var plist: ArchivePlistProtocol
    {
        get { return underlyingPlist }
        set(value) { underlyingPlist = value }
    }

    public var underlyingPlist: ArchivePlistProtocol!
}

// MARK: - ArgumentExecutableProtocolMock

open class ArgumentExecutableProtocolMock: ArgumentExecutableProtocol
{
    public init() {}

    // MARK: - <arguments> - parameters

    public var argumentsThrowableError: Error?
    public var argumentsCallsCount = 0
    public var argumentsCalled: Bool
    {
        return argumentsCallsCount > 0
    }

    public var argumentsReturnValue: Arguments?

    // MARK: - <arguments> - closure mocks

    public var argumentsClosure: (() throws -> Arguments)?

    // MARK: - <arguments> - method mocked

    open func arguments() throws -> Arguments
    {
        // <arguments> - Throwable method implementation

        if let error = argumentsThrowableError
        {
            throw error
        }

        argumentsCallsCount += 1

        // <arguments> - Return Value mock implementation

        guard let closureReturn = argumentsClosure else
        {
            guard let returnValue = argumentsReturnValue else
            {
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
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
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

// MARK: - ArgumentsProtocolMock

open class ArgumentsProtocolMock: ArgumentsProtocol
{
    public init() {}

    public var all: [String] = []
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"
}

// MARK: - DependencyProtocolMock

open class DependencyProtocolMock: DependencyProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var path: String
    {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }

    public var underlyingPath: String = "AutoMockable filled value"
    public var url: URL
    {
        get { return underlyingUrl }
        set(value) { underlyingUrl = value }
    }

    public var underlyingUrl: URL!
    public var version: String
    {
        get { return underlyingVersion }
        set(value) { underlyingVersion = value }
    }

    public var underlyingVersion: String = "AutoMockable filled value"
    public var dependencies: [Dependency] = []
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <gitHooks> - parameters

    public var gitHooksThrowableError: Error?
    public var gitHooksCallsCount = 0
    public var gitHooksCalled: Bool
    {
        return gitHooksCallsCount > 0
    }

    public var gitHooksReturnValue: FolderProtocol?

    // MARK: - <gitHooks> - closure mocks

    public var gitHooksClosure: (() throws -> FolderProtocol)?

    // MARK: - <gitHooks> - method mocked

    open func gitHooks() throws -> FolderProtocol
    {
        // <gitHooks> - Throwable method implementation

        if let error = gitHooksThrowableError
        {
            throw error
        }

        gitHooksCallsCount += 1

        // <gitHooks> - Return Value mock implementation

        guard let closureReturn = gitHooksClosure else
        {
            guard let returnValue = gitHooksReturnValue else
            {
                let message = "No returnValue implemented for gitHooksClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <srcRoot> - parameters

    public var srcRootThrowableError: Error?
    public var srcRootCallsCount = 0
    public var srcRootCalled: Bool
    {
        return srcRootCallsCount > 0
    }

    public var srcRootReturnValue: FolderProtocol?

    // MARK: - <srcRoot> - closure mocks

    public var srcRootClosure: (() throws -> FolderProtocol)?

    // MARK: - <srcRoot> - method mocked

    open func srcRoot() throws -> FolderProtocol
    {
        // <srcRoot> - Throwable method implementation

        if let error = srcRootThrowableError
        {
            throw error
        }

        srcRootCallsCount += 1

        // <srcRoot> - Return Value mock implementation

        guard let closureReturn = srcRootClosure else
        {
            guard let returnValue = srcRootReturnValue else
            {
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
    public var templateFolderCalled: Bool
    {
        return templateFolderCallsCount > 0
    }

    public var templateFolderReturnValue: FolderProtocol?

    // MARK: - <templateFolder> - closure mocks

    public var templateFolderClosure: (() throws -> FolderProtocol)?

    // MARK: - <templateFolder> - method mocked

    open func templateFolder() throws -> FolderProtocol
    {
        // <templateFolder> - Throwable method implementation

        if let error = templateFolderThrowableError
        {
            throw error
        }

        templateFolderCallsCount += 1

        // <templateFolder> - Return Value mock implementation

        guard let closureReturn = templateFolderClosure else
        {
            guard let returnValue = templateFolderReturnValue else
            {
                let message = "No returnValue implemented for templateFolderClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <templateFolder> - parameters

    public var templateFolderExpectedNameThrowableError: Error?
    public var templateFolderExpectedNameCallsCount = 0
    public var templateFolderExpectedNameCalled: Bool
    {
        return templateFolderExpectedNameCallsCount > 0
    }

    public var templateFolderExpectedNameReceivedExpectedName: String?
    public var templateFolderExpectedNameReturnValue: FolderProtocol?

    // MARK: - <templateFolder> - closure mocks

    public var templateFolderExpectedNameClosure: ((String) throws -> FolderProtocol)?

    // MARK: - <templateFolder> - method mocked

    open func templateFolder(expectedName: String) throws -> FolderProtocol
    {
        // <templateFolder> - Throwable method implementation

        if let error = templateFolderExpectedNameThrowableError
        {
            throw error
        }

        templateFolderExpectedNameCallsCount += 1
        templateFolderExpectedNameReceivedExpectedName = expectedName

        // <templateFolder> - Return Value mock implementation

        guard let closureReturn = templateFolderExpectedNameClosure else
        {
            guard let returnValue = templateFolderExpectedNameReturnValue else
            {
                let message = "No returnValue implemented for templateFolderExpectedNameClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FolderProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(expectedName)
    }

    // MARK: - <sourceryFolder> - parameters

    public var sourceryFolderThrowableError: Error?
    public var sourceryFolderCallsCount = 0
    public var sourceryFolderCalled: Bool
    {
        return sourceryFolderCallsCount > 0
    }

    public var sourceryFolderReturnValue: FolderProtocol?

    // MARK: - <sourceryFolder> - closure mocks

    public var sourceryFolderClosure: (() throws -> FolderProtocol)?

    // MARK: - <sourceryFolder> - method mocked

    open func sourceryFolder() throws -> FolderProtocol
    {
        // <sourceryFolder> - Throwable method implementation

        if let error = sourceryFolderThrowableError
        {
            throw error
        }

        sourceryFolderCallsCount += 1

        // <sourceryFolder> - Return Value mock implementation

        guard let closureReturn = sourceryFolderClosure else
        {
            guard let returnValue = sourceryFolderReturnValue else
            {
                let message = "No returnValue implemented for sourceryFolderClosure"
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
    public var sourceryAutoProtocolFileCalled: Bool
    {
        return sourceryAutoProtocolFileCallsCount > 0
    }

    public var sourceryAutoProtocolFileReturnValue: FileProtocol?

    // MARK: - <sourceryAutoProtocolFile> - closure mocks

    public var sourceryAutoProtocolFileClosure: (() throws -> FileProtocol)?

    // MARK: - <sourceryAutoProtocolFile> - method mocked

    open func sourceryAutoProtocolFile() throws -> FileProtocol
    {
        // <sourceryAutoProtocolFile> - Throwable method implementation

        if let error = sourceryAutoProtocolFileThrowableError
        {
            throw error
        }

        sourceryAutoProtocolFileCallsCount += 1

        // <sourceryAutoProtocolFile> - Return Value mock implementation

        guard let closureReturn = sourceryAutoProtocolFileClosure else
        {
            guard let returnValue = sourceryAutoProtocolFileReturnValue else
            {
                let message = "No returnValue implemented for sourceryAutoProtocolFileClosure"
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

open class DependencyServiceProtocolMock: DependencyServiceProtocol
{
    public init() {}

    // MARK: - <generateDependency> - parameters

    public var generateDependencyThrowableError: Error?
    public var generateDependencyCallsCount = 0
    public var generateDependencyCalled: Bool
    {
        return generateDependencyCallsCount > 0
    }

    public var generateDependencyReturnValue: DependencyProtocol?

    // MARK: - <generateDependency> - closure mocks

    public var generateDependencyClosure: (() throws -> DependencyProtocol)?

    // MARK: - <generateDependency> - method mocked

    open func generateDependency() throws -> DependencyProtocol
    {
        // <generateDependency> - Throwable method implementation

        if let error = generateDependencyThrowableError
        {
            throw error
        }

        generateDependencyCallsCount += 1

        // <generateDependency> - Return Value mock implementation

        guard let closureReturn = generateDependencyClosure else
        {
            guard let returnValue = generateDependencyReturnValue else
            {
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

// MARK: - DestinationFactoryProtocolMock

open class DestinationFactoryProtocolMock: DestinationFactoryProtocol
{
    public init() {}

    // MARK: - <macOS> - parameters

    public var macOSArchitectureCallsCount = 0
    public var macOSArchitectureCalled: Bool
    {
        return macOSArchitectureCallsCount > 0
    }

    public var macOSArchitectureReceivedArchitecture: Destination.Architecture?
    public var macOSArchitectureReturnValue: Destination?

    // MARK: - <macOS> - closure mocks

    public var macOSArchitectureClosure: ((Destination.Architecture) -> Destination)?

    // MARK: - <macOS> - method mocked

    open func macOS(architecture: Destination.Architecture) -> Destination
    {
        macOSArchitectureCallsCount += 1
        macOSArchitectureReceivedArchitecture = architecture

        // <macOS> - Return Value mock implementation

        guard let closureReturn = macOSArchitectureClosure else
        {
            guard let returnValue = macOSArchitectureReturnValue else
            {
                let message = "No returnValue implemented for macOSArchitectureClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement Destination

                print("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn(architecture)
    }

    // MARK: - <device> - parameters

    public var deviceNameIsGenericIdCallsCount = 0
    public var deviceNameIsGenericIdCalled: Bool
    {
        return deviceNameIsGenericIdCallsCount > 0
    }

    public var deviceNameIsGenericIdReceivedArguments: (device: Destination.Device, name: String?, isGeneric: Bool, id: String?)?
    public var deviceNameIsGenericIdReturnValue: Destination?

    // MARK: - <device> - closure mocks

    public var deviceNameIsGenericIdClosure: ((Destination.Device, String?, Bool, String?) -> Destination)?

    // MARK: - <device> - method mocked

    open func device(_ device: Destination.Device, name: String?, isGeneric: Bool, id: String?) -> Destination
    {
        deviceNameIsGenericIdCallsCount += 1
        deviceNameIsGenericIdReceivedArguments = (device: device, name: name, isGeneric: isGeneric, id: id)

        // <device> - Return Value mock implementation

        guard let closureReturn = deviceNameIsGenericIdClosure else
        {
            guard let returnValue = deviceNameIsGenericIdReturnValue else
            {
                let message = "No returnValue implemented for deviceNameIsGenericIdClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement Destination

                print("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn(device, name, isGeneric, id)
    }

    // MARK: - <simulator> - parameters

    public var simulatorNameOsIdCallsCount = 0
    public var simulatorNameOsIdCalled: Bool
    {
        return simulatorNameOsIdCallsCount > 0
    }

    public var simulatorNameOsIdReceivedArguments: (simulator: Destination.Simulator, name: String, os: Destination.OS, id: String?)?
    public var simulatorNameOsIdReturnValue: Destination?

    // MARK: - <simulator> - closure mocks

    public var simulatorNameOsIdClosure: ((Destination.Simulator, String, Destination.OS, String?) -> Destination)?

    // MARK: - <simulator> - method mocked

    open func simulator(_ simulator: Destination.Simulator, name: String, os: Destination.OS, id: String?) -> Destination
    {
        simulatorNameOsIdCallsCount += 1
        simulatorNameOsIdReceivedArguments = (simulator: simulator, name: name, os: os, id: id)

        // <simulator> - Return Value mock implementation

        guard let closureReturn = simulatorNameOsIdClosure else
        {
            guard let returnValue = simulatorNameOsIdReturnValue else
            {
                let message = "No returnValue implemented for simulatorNameOsIdClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement Destination

                print("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn(simulator, name, os, id)
    }
}

// MARK: - DestinationProtocolMock

open class DestinationProtocolMock: DestinationProtocol
{
    public init() {}

    public var raw: [String: String] = [:]
    public var asString: String
    {
        get { return underlyingAsString }
        set(value) { underlyingAsString = value }
    }

    public var underlyingAsString: String = "AutoMockable filled value"
}

// MARK: - DumpProtocolMock

open class DumpProtocolMock: DumpProtocol
{
    public init() {}

    public var products: Set<SwiftProduct>
    {
        get { return underlyingProducts }
        set(value) { underlyingProducts = value }
    }

    public var underlyingProducts: Set<SwiftProduct>!
    public var targets: Set<SwiftTarget>
    {
        get { return underlyingTargets }
        set(value) { underlyingTargets = value }
    }

    public var underlyingTargets: Set<SwiftTarget>!
}

// MARK: - DumpServiceProtocolMock

open class DumpServiceProtocolMock: DumpServiceProtocol
{
    public init() {}

    // MARK: - <generateDump> - parameters

    public var generateDumpThrowableError: Error?
    public var generateDumpCallsCount = 0
    public var generateDumpCalled: Bool
    {
        return generateDumpCallsCount > 0
    }

    public var generateDumpReturnValue: DumpProtocol?

    // MARK: - <generateDump> - closure mocks

    public var generateDumpClosure: (() throws -> DumpProtocol)?

    // MARK: - <generateDump> - method mocked

    open func generateDump() throws -> DumpProtocol
    {
        // <generateDump> - Throwable method implementation

        if let error = generateDumpThrowableError
        {
            throw error
        }

        generateDumpCallsCount += 1

        // <generateDump> - Return Value mock implementation

        guard let closureReturn = generateDumpClosure else
        {
            guard let returnValue = generateDumpReturnValue else
            {
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

open class ExecutableProtocolMock: ExecutableProtocol
{
    public init() {}

    // MARK: - <executableFile> - parameters

    public var executableFileThrowableError: Error?
    public var executableFileCallsCount = 0
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
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

// MARK: - ExportArchiveOptionsProtocolMock

open class ExportArchiveOptionsProtocolMock: ExportArchiveOptionsProtocol
{
    public init() {}

    public var archivePath: FolderProtocol
    {
        get { return underlyingArchivePath }
        set(value) { underlyingArchivePath = value }
    }

    public var underlyingArchivePath: FolderProtocol!
    public var exportPath: String
    {
        get { return underlyingExportPath }
        set(value) { underlyingExportPath = value }
    }

    public var underlyingExportPath: String = "AutoMockable filled value"

    // MARK: - <encode> - parameters

    public var encodeToThrowableError: Error?
    public var encodeToCallsCount = 0
    public var encodeToCalled: Bool
    {
        return encodeToCallsCount > 0
    }

    public var encodeToReceivedEncoder: Encoder?

    // MARK: - <encode> - closure mocks

    public var encodeToClosure: ((Encoder) throws -> Void)?

    // MARK: - <encode> - method mocked

    open func encode(to encoder: Encoder) throws
    {
        // <encode> - Throwable method implementation

        if let error = encodeToThrowableError
        {
            throw error
        }

        encodeToCallsCount += 1
        encodeToReceivedEncoder = encoder

        // <encode> - Void return mock implementation

        try encodeToClosure?(encoder)
    }
}

// MARK: - ExportProtocolMock

open class ExportProtocolMock: ExportProtocol
{
    public init() {}

    public var folder: FolderProtocol
    {
        get { return underlyingFolder }
        set(value) { underlyingFolder = value }
    }

    public var underlyingFolder: FolderProtocol!
    public var ipa: FileProtocol
    {
        get { return underlyingIpa }
        set(value) { underlyingIpa = value }
    }

    public var underlyingIpa: FileProtocol!
}

// MARK: - GitToolProtocolMock

open class GitToolProtocolMock: GitToolProtocol
{
    public init() {}

    // MARK: - <isClean> - parameters

    public var isCleanThrowableError: Error?
    public var isCleanCallsCount = 0
    public var isCleanCalled: Bool
    {
        return isCleanCallsCount > 0
    }

    public var isCleanReturnValue: Bool?

    // MARK: - <isClean> - closure mocks

    public var isCleanClosure: (() throws -> Bool)?

    // MARK: - <isClean> - method mocked

    open func isClean() throws -> Bool
    {
        // <isClean> - Throwable method implementation

        if let error = isCleanThrowableError
        {
            throw error
        }

        isCleanCallsCount += 1

        // <isClean> - Return Value mock implementation

        guard let closureReturn = isCleanClosure else
        {
            guard let returnValue = isCleanReturnValue else
            {
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
    public var statusCalled: Bool
    {
        return statusCallsCount > 0
    }

    public var statusReturnValue: [String]?

    // MARK: - <status> - closure mocks

    public var statusClosure: (() throws -> [String])?

    // MARK: - <status> - method mocked

    open func status() throws -> [String]
    {
        // <status> - Throwable method implementation

        if let error = statusThrowableError
        {
            throw error
        }

        statusCallsCount += 1

        // <status> - Return Value mock implementation

        guard let closureReturn = statusClosure else
        {
            guard let returnValue = statusReturnValue else
            {
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
    public var addAllCalled: Bool
    {
        return addAllCallsCount > 0
    }

    public var addAllReturnValue: [String]?

    // MARK: - <addAll> - closure mocks

    public var addAllClosure: (() throws -> [String])?

    // MARK: - <addAll> - method mocked

    open func addAll() throws -> [String]
    {
        // <addAll> - Throwable method implementation

        if let error = addAllThrowableError
        {
            throw error
        }

        addAllCallsCount += 1

        // <addAll> - Return Value mock implementation

        guard let closureReturn = addAllClosure else
        {
            guard let returnValue = addAllReturnValue else
            {
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
    public var commitMessageCalled: Bool
    {
        return commitMessageCallsCount > 0
    }

    public var commitMessageReceivedMessage: String?
    public var commitMessageReturnValue: [String]?

    // MARK: - <commit> - closure mocks

    public var commitMessageClosure: ((String) throws -> [String])?

    // MARK: - <commit> - method mocked

    open func commit(message: String) throws -> [String]
    {
        // <commit> - Throwable method implementation

        if let error = commitMessageThrowableError
        {
            throw error
        }

        commitMessageCallsCount += 1
        commitMessageReceivedMessage = message

        // <commit> - Return Value mock implementation

        guard let closureReturn = commitMessageClosure else
        {
            guard let returnValue = commitMessageReturnValue else
            {
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
    public var pushToMasterCalled: Bool
    {
        return pushToMasterCallsCount > 0
    }

    public var pushToMasterReturnValue: [String]?

    // MARK: - <pushToMaster> - closure mocks

    public var pushToMasterClosure: (() throws -> [String])?

    // MARK: - <pushToMaster> - method mocked

    open func pushToMaster() throws -> [String]
    {
        // <pushToMaster> - Throwable method implementation

        if let error = pushToMasterThrowableError
        {
            throw error
        }

        pushToMasterCallsCount += 1

        // <pushToMaster> - Return Value mock implementation

        guard let closureReturn = pushToMasterClosure else
        {
            guard let returnValue = pushToMasterReturnValue else
            {
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
    public var pushTagsToMasterCalled: Bool
    {
        return pushTagsToMasterCallsCount > 0
    }

    public var pushTagsToMasterReturnValue: [String]?

    // MARK: - <pushTagsToMaster> - closure mocks

    public var pushTagsToMasterClosure: (() throws -> [String])?

    // MARK: - <pushTagsToMaster> - method mocked

    open func pushTagsToMaster() throws -> [String]
    {
        // <pushTagsToMaster> - Throwable method implementation

        if let error = pushTagsToMasterThrowableError
        {
            throw error
        }

        pushTagsToMasterCallsCount += 1

        // <pushTagsToMaster> - Return Value mock implementation

        guard let closureReturn = pushTagsToMasterClosure else
        {
            guard let returnValue = pushTagsToMasterReturnValue else
            {
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
    public var pullCalled: Bool
    {
        return pullCallsCount > 0
    }

    public var pullReturnValue: [String]?

    // MARK: - <pull> - closure mocks

    public var pullClosure: (() throws -> [String])?

    // MARK: - <pull> - method mocked

    open func pull() throws -> [String]
    {
        // <pull> - Throwable method implementation

        if let error = pullThrowableError
        {
            throw error
        }

        pullCallsCount += 1

        // <pull> - Return Value mock implementation

        guard let closureReturn = pullClosure else
        {
            guard let returnValue = pullReturnValue else
            {
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
    public var currentTagCalled: Bool
    {
        return currentTagCallsCount > 0
    }

    public var currentTagReturnValue: [String]?

    // MARK: - <currentTag> - closure mocks

    public var currentTagClosure: (() throws -> [String])?

    // MARK: - <currentTag> - method mocked

    open func currentTag() throws -> [String]
    {
        // <currentTag> - Throwable method implementation

        if let error = currentTagThrowableError
        {
            throw error
        }

        currentTagCallsCount += 1

        // <currentTag> - Return Value mock implementation

        guard let closureReturn = currentTagClosure else
        {
            guard let returnValue = currentTagReturnValue else
            {
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
    public var cloneWithCalled: Bool
    {
        return cloneWithCallsCount > 0
    }

    public var cloneWithReceivedOptions: CloneOptions?
    public var cloneWithReturnValue: [String]?

    // MARK: - <clone> - closure mocks

    public var cloneWithClosure: ((CloneOptions) throws -> [String])?

    // MARK: - <clone> - method mocked

    open func clone(with options: CloneOptions) throws -> [String]
    {
        // <clone> - Throwable method implementation

        if let error = cloneWithThrowableError
        {
            throw error
        }

        cloneWithCallsCount += 1
        cloneWithReceivedOptions = options

        // <clone> - Return Value mock implementation

        guard let closureReturn = cloneWithClosure else
        {
            guard let returnValue = cloneWithReturnValue else
            {
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

// MARK: - MinimalTestOptionsProtocolMock

open class MinimalTestOptionsProtocolMock: MinimalTestOptionsProtocol
{
    public init() {}

    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <arguments> - parameters

    public var argumentsThrowableError: Error?
    public var argumentsCallsCount = 0
    public var argumentsCalled: Bool
    {
        return argumentsCallsCount > 0
    }

    public var argumentsReturnValue: Arguments?

    // MARK: - <arguments> - closure mocks

    public var argumentsClosure: (() throws -> Arguments)?

    // MARK: - <arguments> - method mocked

    open func arguments() throws -> Arguments
    {
        // <arguments> - Throwable method implementation

        if let error = argumentsThrowableError
        {
            throw error
        }

        argumentsCallsCount += 1

        // <arguments> - Return Value mock implementation

        guard let closureReturn = argumentsClosure else
        {
            guard let returnValue = argumentsReturnValue else
            {
                let message = "No returnValue implemented for argumentsClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement Arguments

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }
}

// MARK: - PathEnvironmentParserProtocolMock

open class PathEnvironmentParserProtocolMock: PathEnvironmentParserProtocol
{
    public init() {}

    public var urls: [FolderProtocol] = []
}

// MARK: - ProcessProtocolMock

open class ProcessProtocolMock: ProcessProtocol
{
    public init() {}

    public var standardInput: Any?
    public var standardOutput: Any?
    public var standardError: Any?
    public var terminationStatus: Int32
    {
        get { return underlyingTerminationStatus }
        set(value) { underlyingTerminationStatus = value }
    }

    public var underlyingTerminationStatus: Int32!
    public var arguments: [String]?
    public var currentDirectoryPath: String
    {
        get { return underlyingCurrentDirectoryPath }
        set(value) { underlyingCurrentDirectoryPath = value }
    }

    public var underlyingCurrentDirectoryPath: String = "AutoMockable filled value"
    public var isRunning: Bool
    {
        get { return underlyingIsRunning }
        set(value) { underlyingIsRunning = value }
    }

    public var underlyingIsRunning: Bool = false
    public var terminationHandler: ((Process) -> Void)?

    // MARK: - <resume> - parameters

    public var resumeCallsCount = 0
    public var resumeCalled: Bool
    {
        return resumeCallsCount > 0
    }

    public var resumeReturnValue: Bool?

    // MARK: - <resume> - closure mocks

    public var resumeClosure: (() -> Bool)?

    // MARK: - <resume> - method mocked

    open func resume() -> Bool
    {
        resumeCallsCount += 1

        // <resume> - Return Value mock implementation

        guard let closureReturn = resumeClosure else
        {
            guard let returnValue = resumeReturnValue else
            {
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
    public var _RunCalled: Bool
    {
        return _RunCallsCount > 0
    }

    // MARK: - <_run> - closure mocks

    public var _RunClosure: (() throws -> Void)?

    // MARK: - <_run> - method mocked

    open func _run() throws
    {
        // <_run> - Throwable method implementation

        if let error = _RunThrowableError
        {
            throw error
        }

        _RunCallsCount += 1

        // <_run> - Void return mock implementation

        try _RunClosure?()
    }

    // MARK: - <waitUntilExit> - parameters

    public var waitUntilExitCallsCount = 0
    public var waitUntilExitCalled: Bool
    {
        return waitUntilExitCallsCount > 0
    }

    // MARK: - <waitUntilExit> - closure mocks

    public var waitUntilExitClosure: (() -> Void)?

    // MARK: - <waitUntilExit> - method mocked

    open func waitUntilExit()
    {
        waitUntilExitCallsCount += 1

        // <waitUntilExit> - Void return mock implementation

        waitUntilExitClosure?()
    }

    // MARK: - <executableFile> - parameters

    public var executableFileThrowableError: Error?
    public var executableFileCallsCount = 0
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
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

// MARK: - SwiftProductProtocolMock

open class SwiftProductProtocolMock: SwiftProductProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var product_type: String
    {
        get { return underlyingProduct_type }
        set(value) { underlyingProduct_type = value }
    }

    public var underlyingProduct_type: String = "AutoMockable filled value"
}

// MARK: - SwiftTargetProtocolMock

open class SwiftTargetProtocolMock: SwiftTargetProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var dependencies: Set<SwiftTarget.Dependency>
    {
        get { return underlyingDependencies }
        set(value) { underlyingDependencies = value }
    }

    public var underlyingDependencies: Set<SwiftTarget.Dependency>!
}

// MARK: - SystemProtocolMock

open class SystemProtocolMock: SystemProtocol
{
    public init() {}

    public static var shared: SystemProtocol
    {
        get { return underlyingShared }
        set(value) { underlyingShared = value }
    }

    public static var underlyingShared: SystemProtocol!
    public static var brewPath: String
    {
        get { return underlyingBrewPath }
        set(value) { underlyingBrewPath = value }
    }

    public static var underlyingBrewPath: String = "AutoMockable filled value"
    public static var jazzyPath: String
    {
        get { return underlyingJazzyPath }
        set(value) { underlyingJazzyPath = value }
    }

    public static var underlyingJazzyPath: String = "AutoMockable filled value"
    public var pathEnvironmentParser: PathEnvironmentParserProtocol
    {
        get { return underlyingPathEnvironmentParser }
        set(value) { underlyingPathEnvironmentParser = value }
    }

    public var underlyingPathEnvironmentParser: PathEnvironmentParserProtocol!
    public var fileSystem: FileSystemProtocol
    {
        get { return underlyingFileSystem }
        set(value) { underlyingFileSystem = value }
    }

    public var underlyingFileSystem: FileSystemProtocol!

    // MARK: - <rbenvProcess> - parameters

    public var rbenvProcessInThrowableError: Error?
    public var rbenvProcessInCallsCount = 0
    public var rbenvProcessInCalled: Bool
    {
        return rbenvProcessInCallsCount > 0
    }

    public var rbenvProcessInReceivedFolder: FolderProtocol?
    public var rbenvProcessInReturnValue: ProcessProtocol?

    // MARK: - <rbenvProcess> - closure mocks

    public var rbenvProcessInClosure: ((FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <rbenvProcess> - method mocked

    open func rbenvProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <rbenvProcess> - Throwable method implementation

        if let error = rbenvProcessInThrowableError
        {
            throw error
        }

        rbenvProcessInCallsCount += 1
        rbenvProcessInReceivedFolder = folder

        // <rbenvProcess> - Return Value mock implementation

        guard let closureReturn = rbenvProcessInClosure else
        {
            guard let returnValue = rbenvProcessInReturnValue else
            {
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
    public var gemProcessNameInCalled: Bool
    {
        return gemProcessNameInCallsCount > 0
    }

    public var gemProcessNameInReceivedArguments: (name: String, folder: FolderProtocol)?
    public var gemProcessNameInReturnValue: ProcessProtocol?

    // MARK: - <gemProcess> - closure mocks

    public var gemProcessNameInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <gemProcess> - method mocked

    open func gemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <gemProcess> - Throwable method implementation

        if let error = gemProcessNameInThrowableError
        {
            throw error
        }

        gemProcessNameInCallsCount += 1
        gemProcessNameInReceivedArguments = (name: name, folder: folder)

        // <gemProcess> - Return Value mock implementation

        guard let closureReturn = gemProcessNameInClosure else
        {
            guard let returnValue = gemProcessNameInReturnValue else
            {
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
    public var rbenvWhichProcessGemNameInCalled: Bool
    {
        return rbenvWhichProcessGemNameInCallsCount > 0
    }

    public var rbenvWhichProcessGemNameInReceivedArguments: (gemName: String, folder: FolderProtocol)?
    public var rbenvWhichProcessGemNameInReturnValue: ProcessProtocol?

    // MARK: - <rbenvWhichProcess> - closure mocks

    public var rbenvWhichProcessGemNameInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <rbenvWhichProcess> - method mocked

    open func rbenvWhichProcess(gemName: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <rbenvWhichProcess> - Throwable method implementation

        if let error = rbenvWhichProcessGemNameInThrowableError
        {
            throw error
        }

        rbenvWhichProcessGemNameInCallsCount += 1
        rbenvWhichProcessGemNameInReceivedArguments = (gemName: gemName, folder: folder)

        // <rbenvWhichProcess> - Return Value mock implementation

        guard let closureReturn = rbenvWhichProcessGemNameInClosure else
        {
            guard let returnValue = rbenvWhichProcessGemNameInReturnValue else
            {
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
    public var installOrFindGemProcessNameInCalled: Bool
    {
        return installOrFindGemProcessNameInCallsCount > 0
    }

    public var installOrFindGemProcessNameInReceivedArguments: (name: String, folder: FolderProtocol)?
    public var installOrFindGemProcessNameInReturnValue: ProcessProtocol?

    // MARK: - <installOrFindGemProcess> - closure mocks

    public var installOrFindGemProcessNameInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <installOrFindGemProcess> - method mocked

    open func installOrFindGemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <installOrFindGemProcess> - Throwable method implementation

        if let error = installOrFindGemProcessNameInThrowableError
        {
            throw error
        }

        installOrFindGemProcessNameInCallsCount += 1
        installOrFindGemProcessNameInReceivedArguments = (name: name, folder: folder)

        // <installOrFindGemProcess> - Return Value mock implementation

        guard let closureReturn = installOrFindGemProcessNameInClosure else
        {
            guard let returnValue = installOrFindGemProcessNameInReturnValue else
            {
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
    public var processFromBrewFormulaInCalled: Bool
    {
        return processFromBrewFormulaInCallsCount > 0
    }

    public var processFromBrewFormulaInReceivedArguments: (formula: String, folder: FolderProtocol)?
    public var processFromBrewFormulaInReturnValue: ProcessProtocol?

    // MARK: - <processFromBrew> - closure mocks

    public var processFromBrewFormulaInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <processFromBrew> - method mocked

    open func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <processFromBrew> - Throwable method implementation

        if let error = processFromBrewFormulaInThrowableError
        {
            throw error
        }

        processFromBrewFormulaInCallsCount += 1
        processFromBrewFormulaInReceivedArguments = (formula: formula, folder: folder)

        // <processFromBrew> - Return Value mock implementation

        guard let closureReturn = processFromBrewFormulaInClosure else
        {
            guard let returnValue = processFromBrewFormulaInReturnValue else
            {
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
    public var installOrGetProcessFromBrewFormulaInCalled: Bool
    {
        return installOrGetProcessFromBrewFormulaInCallsCount > 0
    }

    public var installOrGetProcessFromBrewFormulaInReceivedArguments: (formula: String, folder: FolderProtocol)?
    public var installOrGetProcessFromBrewFormulaInReturnValue: ProcessProtocol?

    // MARK: - <installOrGetProcessFromBrew> - closure mocks

    public var installOrGetProcessFromBrewFormulaInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <installOrGetProcessFromBrew> - method mocked

    open func installOrGetProcessFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <installOrGetProcessFromBrew> - Throwable method implementation

        if let error = installOrGetProcessFromBrewFormulaInThrowableError
        {
            throw error
        }

        installOrGetProcessFromBrewFormulaInCallsCount += 1
        installOrGetProcessFromBrewFormulaInReceivedArguments = (formula: formula, folder: folder)

        // <installOrGetProcessFromBrew> - Return Value mock implementation

        guard let closureReturn = installOrGetProcessFromBrewFormulaInClosure else
        {
            guard let returnValue = installOrGetProcessFromBrewFormulaInReturnValue else
            {
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
    public var brewListProcessForInCalled: Bool
    {
        return brewListProcessForInCallsCount > 0
    }

    public var brewListProcessForInReceivedArguments: (formula: String, folder: FolderProtocol)?
    public var brewListProcessForInReturnValue: ProcessProtocol?

    // MARK: - <brewListProcess> - closure mocks

    public var brewListProcessForInClosure: ((String, FolderProtocol) throws -> ProcessProtocol)?

    // MARK: - <brewListProcess> - method mocked

    open func brewListProcess(for formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        // <brewListProcess> - Throwable method implementation

        if let error = brewListProcessForInThrowableError
        {
            throw error
        }

        brewListProcessForInCallsCount += 1
        brewListProcessForInReceivedArguments = (formula: formula, folder: folder)

        // <brewListProcess> - Return Value mock implementation

        guard let closureReturn = brewListProcessForInClosure else
        {
            guard let returnValue = brewListProcessForInReturnValue else
            {
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
    public var processCalled: Bool
    {
        return processCallsCount > 0
    }

    public var processReceivedExecutableName: String?
    public var processReturnValue: ProcessProtocol?

    // MARK: - <process> - closure mocks

    public var processClosure: ((String) throws -> ProcessProtocol)?

    // MARK: - <process> - method mocked

    open func process(_ executableName: String) throws -> ProcessProtocol
    {
        // <process> - Throwable method implementation

        if let error = processThrowableError
        {
            throw error
        }

        processCallsCount += 1
        processReceivedExecutableName = executableName

        // <process> - Return Value mock implementation

        guard let closureReturn = processClosure else
        {
            guard let returnValue = processReturnValue else
            {
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
    public var processCurrentFolderExecutablePathCalled: Bool
    {
        return processCurrentFolderExecutablePathCallsCount > 0
    }

    public var processCurrentFolderExecutablePathReceivedArguments: (currentFolder: FolderProtocol, executablePath: String)?
    public var processCurrentFolderExecutablePathReturnValue: ProcessProtocol?

    // MARK: - <process> - closure mocks

    public var processCurrentFolderExecutablePathClosure: ((FolderProtocol, String) throws -> ProcessProtocol)?

    // MARK: - <process> - method mocked

    open func process(currentFolder: FolderProtocol, executablePath: String) throws -> ProcessProtocol
    {
        // <process> - Throwable method implementation

        if let error = processCurrentFolderExecutablePathThrowableError
        {
            throw error
        }

        processCurrentFolderExecutablePathCallsCount += 1
        processCurrentFolderExecutablePathReceivedArguments = (currentFolder: currentFolder, executablePath: executablePath)

        // <process> - Return Value mock implementation

        guard let closureReturn = processCurrentFolderExecutablePathClosure else
        {
            guard let returnValue = processCurrentFolderExecutablePathReturnValue else
            {
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
    public var processCurrentFolderExecutableFileCalled: Bool
    {
        return processCurrentFolderExecutableFileCallsCount > 0
    }

    public var processCurrentFolderExecutableFileReceivedArguments: (currentFolder: FolderProtocol, executableFile: FileProtocol)?
    public var processCurrentFolderExecutableFileReturnValue: ProcessProtocol?

    // MARK: - <process> - closure mocks

    public var processCurrentFolderExecutableFileClosure: ((FolderProtocol, FileProtocol) throws -> ProcessProtocol)?

    // MARK: - <process> - method mocked

    open func process(currentFolder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol
    {
        // <process> - Throwable method implementation

        if let error = processCurrentFolderExecutableFileThrowableError
        {
            throw error
        }

        processCurrentFolderExecutableFileCallsCount += 1
        processCurrentFolderExecutableFileReceivedArguments = (currentFolder: currentFolder, executableFile: executableFile)

        // <process> - Return Value mock implementation

        guard let closureReturn = processCurrentFolderExecutableFileClosure else
        {
            guard let returnValue = processCurrentFolderExecutableFileReturnValue else
            {
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
    public var executableWithCalled: Bool
    {
        return executableWithCallsCount > 0
    }

    public var executableWithReceivedExecutableName: String?
    public var executableWithReturnValue: FileProtocol?

    // MARK: - <executable> - closure mocks

    public var executableWithClosure: ((String) throws -> FileProtocol)?

    // MARK: - <executable> - method mocked

    open func executable(with executableName: String) throws -> FileProtocol
    {
        // <executable> - Throwable method implementation

        if let error = executableWithThrowableError
        {
            throw error
        }

        executableWithCallsCount += 1
        executableWithReceivedExecutableName = executableName

        // <executable> - Return Value mock implementation

        guard let closureReturn = executableWithClosure else
        {
            guard let returnValue = executableWithReturnValue else
            {
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

open class TaskProtocolMock: TaskProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var executable: FileProtocol
    {
        get { return underlyingExecutable }
        set(value) { underlyingExecutable = value }
    }

    public var underlyingExecutable: FileProtocol!
    public var arguments: Arguments
    {
        get { return underlyingArguments }
        set(value) { underlyingArguments = value }
    }

    public var underlyingArguments: Arguments!
    public var input: Channel
    {
        get { return underlyingInput }
        set(value) { underlyingInput = value }
    }

    public var underlyingInput: Channel!
    public var output: Channel
    {
        get { return underlyingOutput }
        set(value) { underlyingOutput = value }
    }

    public var underlyingOutput: Channel!
    public var capturedOutputData: Data?
    public var readOutputString: String?
    public var trimmedOutput: String?
    public var capturedOutputString: String?
    public var toProcess: ProcessProtocol
    {
        get { return underlyingToProcess }
        set(value) { underlyingToProcess = value }
    }

    public var underlyingToProcess: ProcessProtocol!
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <enableReadableOutputDataCapturing> - parameters

    public var enableReadableOutputDataCapturingCallsCount = 0
    public var enableReadableOutputDataCapturingCalled: Bool
    {
        return enableReadableOutputDataCapturingCallsCount > 0
    }

    // MARK: - <enableReadableOutputDataCapturing> - closure mocks

    public var enableReadableOutputDataCapturingClosure: (() -> Void)?

    // MARK: - <enableReadableOutputDataCapturing> - method mocked

    open func enableReadableOutputDataCapturing()
    {
        enableReadableOutputDataCapturingCallsCount += 1

        // <enableReadableOutputDataCapturing> - Void return mock implementation

        enableReadableOutputDataCapturingClosure?()
    }
}

// MARK: - TerminalProtocolMock

open class TerminalProtocolMock: TerminalProtocol
{
    public init() {}

    // MARK: - <terminal> - parameters

    public var terminalTaskThrowableError: Error?
    public var terminalTaskCallsCount = 0
    public var terminalTaskCalled: Bool
    {
        return terminalTaskCallsCount > 0
    }

    public var terminalTaskReceivedTask: TerminalTask?
    public var terminalTaskReturnValue: [String]?

    // MARK: - <terminal> - closure mocks

    public var terminalTaskClosure: ((TerminalTask) throws -> [String])?

    // MARK: - <terminal> - method mocked

    open func terminal(task: TerminalTask) throws -> [String]
    {
        // <terminal> - Throwable method implementation

        if let error = terminalTaskThrowableError
        {
            throw error
        }

        terminalTaskCallsCount += 1
        terminalTaskReceivedTask = task

        // <terminal> - Return Value mock implementation

        guard let closureReturn = terminalTaskClosure else
        {
            guard let returnValue = terminalTaskReturnValue else
            {
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
    public var runExecutableCalled: Bool
    {
        return runExecutableCallsCount > 0
    }

    public var runExecutableReceivedExecutable: ExecutableProtocol?
    public var runExecutableReturnValue: [String]?

    // MARK: - <runExecutable> - closure mocks

    public var runExecutableClosure: ((ExecutableProtocol) throws -> [String])?

    // MARK: - <runExecutable> - method mocked

    open func runExecutable(_ executable: ExecutableProtocol) throws -> [String]
    {
        // <runExecutable> - Throwable method implementation

        if let error = runExecutableThrowableError
        {
            throw error
        }

        runExecutableCallsCount += 1
        runExecutableReceivedExecutable = executable

        // <runExecutable> - Return Value mock implementation

        guard let closureReturn = runExecutableClosure else
        {
            guard let returnValue = runExecutableReturnValue else
            {
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
    public var runProcessCalled: Bool
    {
        return runProcessCallsCount > 0
    }

    public var runProcessReceivedProcessTask: ProcessProtocol?
    public var runProcessReturnValue: [String]?

    // MARK: - <runProcess> - closure mocks

    public var runProcessClosure: ((ProcessProtocol) throws -> [String])?

    // MARK: - <runProcess> - method mocked

    open func runProcess(_ processTask: ProcessProtocol) throws -> [String]
    {
        // <runProcess> - Throwable method implementation

        if let error = runProcessThrowableError
        {
            throw error
        }

        runProcessCallsCount += 1
        runProcessReceivedProcessTask = processTask

        // <runProcess> - Return Value mock implementation

        guard let closureReturn = runProcessClosure else
        {
            guard let returnValue = runProcessReturnValue else
            {
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

// MARK: - TestOptionsProtocolMock

open class TestOptionsProtocolMock: TestOptionsProtocol
{
    public init() {}

    public var scheme: String
    {
        get { return underlyingScheme }
        set(value) { underlyingScheme = value }
    }

    public var underlyingScheme: String = "AutoMockable filled value"
    public var project: String
    {
        get { return underlyingProject }
        set(value) { underlyingProject = value }
    }

    public var underlyingProject: String = "AutoMockable filled value"
    public var destination: DestinationProtocol
    {
        get { return underlyingDestination }
        set(value) { underlyingDestination = value }
    }

    public var underlyingDestination: DestinationProtocol!
    public var resultBundlePath: String
    {
        get { return underlyingResultBundlePath }
        set(value) { underlyingResultBundlePath = value }
    }

    public var underlyingResultBundlePath: String = "AutoMockable filled value"
    public var derivedDataPath: FolderProtocol?

    // MARK: - <arguments> - parameters

    public var argumentsThrowableError: Error?
    public var argumentsCallsCount = 0
    public var argumentsCalled: Bool
    {
        return argumentsCallsCount > 0
    }

    public var argumentsReturnValue: Arguments?

    // MARK: - <arguments> - closure mocks

    public var argumentsClosure: (() throws -> Arguments)?

    // MARK: - <arguments> - method mocked

    open func arguments() throws -> Arguments
    {
        // <arguments> - Throwable method implementation

        if let error = argumentsThrowableError
        {
            throw error
        }

        argumentsCallsCount += 1

        // <arguments> - Return Value mock implementation

        guard let closureReturn = argumentsClosure else
        {
            guard let returnValue = argumentsReturnValue else
            {
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
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
                let message = "No returnValue implemented for executableFileClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement FileProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn()
    }

    // MARK: - <arguments> - parameters

    public var argumentsThrowableError: Error?
    public var argumentsCallsCount = 0
    public var argumentsCalled: Bool
    {
        return argumentsCallsCount > 0
    }

    public var argumentsReturnValue: Arguments?

    // MARK: - <arguments> - closure mocks

    public var argumentsClosure: (() throws -> Arguments)?

    // MARK: - <arguments> - method mocked

    open func arguments() throws -> Arguments
    {
        // <arguments> - Throwable method implementation

        if let error = argumentsThrowableError
        {
            throw error
        }

        argumentsCallsCount += 1

        // <arguments> - Return Value mock implementation

        guard let closureReturn = argumentsClosure else
        {
            guard let returnValue = argumentsReturnValue else
            {
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
    public var executableFileCalled: Bool
    {
        return executableFileCallsCount > 0
    }

    public var executableFileReturnValue: FileProtocol?

    // MARK: - <executableFile> - closure mocks

    public var executableFileClosure: (() throws -> FileProtocol)?

    // MARK: - <executableFile> - method mocked

    open func executableFile() throws -> FileProtocol
    {
        // <executableFile> - Throwable method implementation

        if let error = executableFileThrowableError
        {
            throw error
        }

        executableFileCallsCount += 1

        // <executableFile> - Return Value mock implementation

        guard let closureReturn = executableFileClosure else
        {
            guard let returnValue = executableFileReturnValue else
            {
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

// MARK: - TestReportProtocolMock

open class TestReportProtocolMock: TestReportProtocol
{
    public init() {}

    public var testSuiteOutput: [String] = []
    public var output: [String] = []
    public var totalNumberOfTests: Int
    {
        get { return underlyingTotalNumberOfTests }
        set(value) { underlyingTotalNumberOfTests = value }
    }

    public var underlyingTotalNumberOfTests: Int = -100
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"
}

// MARK: - XCBuildDestinationsProtocolMock

open class XCBuildDestinationsProtocolMock: XCBuildDestinationsProtocol
{
    public init() {}

    public var platform: Destination.Platform
    {
        get { return underlyingPlatform }
        set(value) { underlyingPlatform = value }
    }

    public var underlyingPlatform: Destination.Platform!
    public var id: String
    {
        get { return underlyingId }
        set(value) { underlyingId = value }
    }

    public var underlyingId: String = "AutoMockable filled value"
    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var os: Destination.OS
    {
        get { return underlyingOs }
        set(value) { underlyingOs = value }
    }

    public var underlyingOs: Destination.OS!
}

// MARK: - XCBuildProtocolMock

open class XCBuildProtocolMock: XCBuildProtocol
{
    public init() {}

    // MARK: - <findPosibleDestinations> - parameters

    public var findPosibleDestinationsForInThrowableError: Error?
    public var findPosibleDestinationsForInCallsCount = 0
    public var findPosibleDestinationsForInCalled: Bool
    {
        return findPosibleDestinationsForInCallsCount > 0
    }

    public var findPosibleDestinationsForInReceivedArguments: (scheme: String, workspace: FolderProtocol)?
    public var findPosibleDestinationsForInReturnValue: [String]?

    // MARK: - <findPosibleDestinations> - closure mocks

    public var findPosibleDestinationsForInClosure: ((String, FolderProtocol) throws -> [String])?

    // MARK: - <findPosibleDestinations> - method mocked

    open func findPosibleDestinations(for scheme: String, in workspace: FolderProtocol) throws -> [String]
    {
        // <findPosibleDestinations> - Throwable method implementation

        if let error = findPosibleDestinationsForInThrowableError
        {
            throw error
        }

        findPosibleDestinationsForInCallsCount += 1
        findPosibleDestinationsForInReceivedArguments = (scheme: scheme, workspace: workspace)

        // <findPosibleDestinations> - Return Value mock implementation

        guard let closureReturn = findPosibleDestinationsForInClosure else
        {
            guard let returnValue = findPosibleDestinationsForInReturnValue else
            {
                let message = "No returnValue implemented for findPosibleDestinationsForInClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement [String]

                throw error
            }
            return returnValue
        }

        return try closureReturn(scheme, workspace)
    }

    // MARK: - <archive> - parameters

    public var archiveUsingThrowableError: Error?
    public var archiveUsingCallsCount = 0
    public var archiveUsingCalled: Bool
    {
        return archiveUsingCallsCount > 0
    }

    public var archiveUsingReceivedOptions: ArchiveOptionsProtocol?
    public var archiveUsingReturnValue: ArchiveProtocol?

    // MARK: - <archive> - closure mocks

    public var archiveUsingClosure: ((ArchiveOptionsProtocol) throws -> ArchiveProtocol)?

    // MARK: - <archive> - method mocked

    open func archive(using options: ArchiveOptionsProtocol) throws -> ArchiveProtocol
    {
        // <archive> - Throwable method implementation

        if let error = archiveUsingThrowableError
        {
            throw error
        }

        archiveUsingCallsCount += 1
        archiveUsingReceivedOptions = options

        // <archive> - Return Value mock implementation

        guard let closureReturn = archiveUsingClosure else
        {
            guard let returnValue = archiveUsingReturnValue else
            {
                let message = "No returnValue implemented for archiveUsingClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement ArchiveProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(options)
    }

    // MARK: - <export> - parameters

    public var exportUsingThrowableError: Error?
    public var exportUsingCallsCount = 0
    public var exportUsingCalled: Bool
    {
        return exportUsingCallsCount > 0
    }

    public var exportUsingReceivedOptions: ExportArchiveOptionsProtocol?
    public var exportUsingReturnValue: ExportProtocol?

    // MARK: - <export> - closure mocks

    public var exportUsingClosure: ((ExportArchiveOptionsProtocol) throws -> ExportProtocol)?

    // MARK: - <export> - method mocked

    open func export(using options: ExportArchiveOptionsProtocol) throws -> ExportProtocol
    {
        // <export> - Throwable method implementation

        if let error = exportUsingThrowableError
        {
            throw error
        }

        exportUsingCallsCount += 1
        exportUsingReceivedOptions = options

        // <export> - Return Value mock implementation

        guard let closureReturn = exportUsingClosure else
        {
            guard let returnValue = exportUsingReturnValue else
            {
                let message = "No returnValue implemented for exportUsingClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement ExportProtocol

                throw error
            }
            return returnValue
        }

        return try closureReturn(options)
    }

    // MARK: - <buildAndTest> - parameters

    public var buildAndTestUsingThrowableError: Error?
    public var buildAndTestUsingCallsCount = 0
    public var buildAndTestUsingCalled: Bool
    {
        return buildAndTestUsingCallsCount > 0
    }

    public var buildAndTestUsingReceivedOptions: MinimalTestOptionsProtocol?
    public var buildAndTestUsingReturnValue: TestReportProtocol?

    // MARK: - <buildAndTest> - closure mocks

    public var buildAndTestUsingClosure: ((MinimalTestOptionsProtocol) throws -> TestReportProtocol)?

    // MARK: - <buildAndTest> - method mocked

    open func buildAndTest(using options: MinimalTestOptionsProtocol) throws -> TestReportProtocol
    {
        // <buildAndTest> - Throwable method implementation

        if let error = buildAndTestUsingThrowableError
        {
            throw error
        }

        buildAndTestUsingCallsCount += 1
        buildAndTestUsingReceivedOptions = options

        // <buildAndTest> - Return Value mock implementation

        guard let closureReturn = buildAndTestUsingClosure else
        {
            guard let returnValue = buildAndTestUsingReturnValue else
            {
                let message = "No returnValue implemented for buildAndTestUsingClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement TestReportProtocol

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
