import Foundation
import os
import SourceryAutoProtocols
import SourceryWorker
import ZFile
import ZFileMock

// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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

// MARK: - SourceryExecutableFileProtocolMock

open class SourceryExecutableFileProtocolMock: FileProtocolMock, SourceryExecutableFileProtocol
{}

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
