//
//  GitHooksWorker.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal

public protocol GitHooksWorkerProtocol: AutoMockable
{
    // highway:inline:GitHooksWorker.AutoGenerateProtocol
    var terminal: TerminalWorkerProtocol { get }
    // highway:end
}

/// Adds a swift build step and runs HighWay Setup <#your executable#> from .git>Hooks/pre-push
public struct GitHooksWorker: GitHooksWorkerProtocol, AutoGenerateProtocol
{
    public let terminal: TerminalWorkerProtocol

    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared)
    {
        self.terminal = terminal
    }
}
