import Foundation
import os
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import TerminalMock
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - ImportProtocolMock

open class ImportProtocolMock: ImportProtocol
{
    public init() {}

    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var testable: Bool
    {
        get { return underlyingTestable }
        set(value) { underlyingTestable = value }
    }

    public var underlyingTestable: Bool = false
}

// MARK: - SourceryBuilderProtocolMock

open class SourceryBuilderProtocolMock: SourceryBuilderProtocol
{
    public init() {}

    public static var executalbeName: String
    {
        get { return underlyingExecutalbeName }
        set(value) { underlyingExecutalbeName = value }
    }

    public static var underlyingExecutalbeName: String = "AutoMockable filled value"

    // MARK: - <attemptToBuildSourceryIfNeeded> - parameters

    public var attemptToBuildSourceryIfNeededThrowableError: Error?
    public var attemptToBuildSourceryIfNeededCallsCount = 0
    public var attemptToBuildSourceryIfNeededCalled: Bool
    {
        return attemptToBuildSourceryIfNeededCallsCount > 0
    }

    public var attemptToBuildSourceryIfNeededReturnValue: FileProtocol?

    // MARK: - <attemptToBuildSourceryIfNeeded> - closure mocks

    public var attemptToBuildSourceryIfNeededClosure: (() throws -> FileProtocol)?

    // MARK: - <attemptToBuildSourceryIfNeeded> - method mocked

    open func attemptToBuildSourceryIfNeeded() throws -> FileProtocol
    {
        // <attemptToBuildSourceryIfNeeded> - Throwable method implementation

        if let error = attemptToBuildSourceryIfNeededThrowableError
        {
            throw error
        }

        attemptToBuildSourceryIfNeededCallsCount += 1

        // <attemptToBuildSourceryIfNeeded> - Return Value mock implementation

        guard let closureReturn = attemptToBuildSourceryIfNeededClosure else
        {
            guard let returnValue = attemptToBuildSourceryIfNeededReturnValue else
            {
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

open class SourceryExecutableFileProtocolMock: FileProtocolMock, SourceryExecutableFileProtocol
{}

// MARK: - SourceryProtocolMock

open class SourceryProtocolMock: ExecutableProtocolMock, SourceryProtocol
{
    public var uuid: String
    {
        get { return underlyingUuid }
        set(value) { underlyingUuid = value }
    }

    public var underlyingUuid: String = "AutoMockable filled value"
    public var name: String
    {
        get { return underlyingName }
        set(value) { underlyingName = value }
    }

    public var underlyingName: String = "AutoMockable filled value"
    public var templateFolder: FolderProtocol
    {
        get { return underlyingTemplateFolder }
        set(value) { underlyingTemplateFolder = value }
    }

    public var underlyingTemplateFolder: FolderProtocol!
    public var outputFolder: FolderProtocol
    {
        get { return underlyingOutputFolder }
        set(value) { underlyingOutputFolder = value }
    }

    public var underlyingOutputFolder: FolderProtocol!
    public var sourcesFolders: [FolderProtocol] = []
    public var individualSourceFiles: [File]?
    public var sourceryAutoProtocolsFile: FileProtocol
    {
        get { return underlyingSourceryAutoProtocolsFile }
        set(value) { underlyingSourceryAutoProtocolsFile = value }
    }

    public var underlyingSourceryAutoProtocolsFile: FileProtocol!
    public var sourceryYMLFile: FileProtocol
    {
        get { return underlyingSourceryYMLFile }
        set(value) { underlyingSourceryYMLFile = value }
    }

    public var underlyingSourceryYMLFile: FileProtocol!
    public var sourceryExecutableFile: FileProtocol
    {
        get { return underlyingSourceryExecutableFile }
        set(value) { underlyingSourceryExecutableFile = value }
    }

    public var underlyingSourceryExecutableFile: FileProtocol!
    public var imports: Set<TemplatePrepend>
    {
        get { return underlyingImports }
        set(value) { underlyingImports = value }
    }

    public var underlyingImports: Set<TemplatePrepend>!
}

// MARK: - TemplatePrependProtocolMock

open class TemplatePrependProtocolMock: TemplatePrependProtocol
{
    public init() {}

    public var names: Set<TemplatePrepend.Import>
    {
        get { return underlyingNames }
        set(value) { underlyingNames = value }
    }

    public var underlyingNames: Set<TemplatePrepend.Import>!
    public var template: String
    {
        get { return underlyingTemplate }
        set(value) { underlyingTemplate = value }
    }

    public var underlyingTemplate: String = "AutoMockable filled value"
}

// MARK: - OBJECTIVE-C
