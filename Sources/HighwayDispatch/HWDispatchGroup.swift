//
//  HWDispatchGroup.swift
//  HighwayDispatch
//
//  Created by Stijn Willems on 23/03/2019.
//

import Foundation
import SourceryAutoProtocols

public protocol HWDispatchGroupProtocol: AutoMockable
{
    func leave()
    func enter()
    func wait()

    func notifyMain(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchGroup: HWDispatchGroupProtocol
{
    public func notifyMain(execute work: @escaping @convention(block) () -> Void)
    {
        notify(queue: DispatchQueue.main, execute: work)
    }
}
