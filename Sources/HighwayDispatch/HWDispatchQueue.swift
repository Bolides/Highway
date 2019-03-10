//
//  HWDispatchQueue.swift
//  Errors
//
//  Created by Stijn Willems on 10/03/2019.
//

import Foundation

import SourceryAutoProtocols

public protocol HighwayDispatchProtocol: AutoMockable
{
    // sourcery:inline:HighwayDispatch.AutoGenerateProtocol

    func async(sync: @escaping () -> Void)
    // sourcery:end
}

public struct HighwayDispatch: HighwayDispatchProtocol, AutoGenerateProtocol
{
    // sourcery:skipProtocol
    public let queue: DispatchQueue

    public init(queue: DispatchQueue)
    {
        self.queue = queue
    }

    public func async(sync: @escaping () -> Void)
    {
        queue.async
        {
            sync()
        }
    }
}

extension DispatchQueue: HighwayDispatchProtocol
{
    public func async(sync: @escaping () -> Void)
    {
        async(execute: sync)
    }
}
