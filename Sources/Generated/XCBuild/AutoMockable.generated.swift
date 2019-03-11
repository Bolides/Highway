import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import XCBuild
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

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

                signPost.error("❌ \(error)")

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

                signPost.error("❌ \(error)")

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

                signPost.error("❌ \(error)")

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

// MARK: - TestReportProtocolMock

open class TestReportProtocolMock: TestReportProtocol
{
    public init() {}

    public var failingTests: ArraySlice<String>?
    public var buildErrors: [String]?
    public var output: [String] = []
    public var description: String
    {
        get { return underlyingDescription }
        set(value) { underlyingDescription = value }
    }

    public var underlyingDescription: String = "AutoMockable filled value"

    // MARK: - <failedTests> - parameters

    public var failedTestsCallsCount = 0
    public var failedTestsCalled: Bool
    {
        return failedTestsCallsCount > 0
    }

    public var failedTestsReturnValue: String?

    // MARK: - <failedTests> - closure mocks

    public var failedTestsClosure: (() -> String)?

    // MARK: - <failedTests> - method mocked

    open func failedTests() -> String
    {
        failedTestsCallsCount += 1

        // <failedTests> - Return Value mock implementation

        guard let closureReturn = failedTestsClosure else
        {
            guard let returnValue = failedTestsReturnValue else
            {
                let message = "No returnValue implemented for failedTestsClosure"
                let error = SourceryMockError.implementErrorCaseFor(message)

                // You should implement String

                signPost.error("❌ \(error)")

                fatalError("\(self) \(#function) should be mocked with return value or be able to throw")
            }
            return returnValue
        }

        return closureReturn()
    }
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
