//
//  SourceryWorkerProtocol.swift
//  SourceryWorker
//
//  Created by Stijn Willems on 12/03/2019.
//

import Foundation
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import Terminal

public protocol SourceryWorkerProtocol: AutoMockable
{
    // sourcery:inline:SourceryWorker.AutoGenerateProtocol
    var sourcery: SourceryProtocol { get }

    init(
        sourcery: SourceryProtocol,
        terminalWorker: TerminalProtocol,
        signPost: SignPostProtocol,
        queue: HighwayDispatchProtocol
    ) throws
    func executor() throws -> ArgumentExecutableProtocol
    func attempt(_ asyncSourceryWorkerOutput: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)

    // sourcery:end
}
