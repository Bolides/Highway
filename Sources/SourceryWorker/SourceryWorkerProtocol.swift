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
import ZFile

public protocol SourceryWorkerProtocol: class, AutoMockable
{
    // sourcery:inline:SourceryWorker.AutoGenerateProtocol
    var name: String { get }
    var sourceryYMLFile: FileProtocol { get }

    init(
      sourcery: SourceryProtocol,
      terminal: TerminalProtocol,
      signPost: SignPostProtocol,
      queue: HighwayDispatchProtocol
    ) 
    func attempt(in folder: FolderProtocol, _ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)

    // sourcery:end
}
