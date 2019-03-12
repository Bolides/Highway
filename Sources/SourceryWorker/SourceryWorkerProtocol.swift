//
//  SourceryWorkerProtocol.swift
//  SourceryWorker
//
//  Created by Stijn Willems on 12/03/2019.
//

import Foundation
import SourceryAutoProtocols
import Terminal

public protocol SourceryWorkerProtocol: AutoMockable
{
    // sourcery:inline:SourceryWorker.AutoGenerateProtocol
    var sourcery: SourceryProtocol { get }

    func executor() throws -> ArgumentExecutableProtocol
    func attempt(_ asyncSourceryWorkerOutput: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)

    // sourcery:end
}
