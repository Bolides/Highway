import Foundation
import GitHooks
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile
import ZFileMock

// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SignPost

let signPost = SignPost.shared

// MARK: - GitHooksWorkerProtocolMock

open class GitHooksWorkerProtocolMock: GitHooksWorkerProtocol
{
    public init() {}

    public var terminal: TerminalWorkerProtocol
    {
        get { return underlyingTerminal }
        set(value) { underlyingTerminal = value }
    }

    public var underlyingTerminal: TerminalWorkerProtocol!
}

// MARK: - OBJECTIVE-C
