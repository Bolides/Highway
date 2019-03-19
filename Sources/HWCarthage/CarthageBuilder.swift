//
//  CarthageBuilder.swift
//  CleanCheckoutFramework
//
//  Created by Stijn Willems on 19/03/2019.
//

import Errors
import Foundation
import Highway
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import Terminal

public protocol CarthageBuilderProtocol: AutoMockable
{
    // sourcery:inline:CarthageBuilder.AutoGenerateProtocol

    func attempt(_ async: @escaping (@escaping CarthageBuilder.SyncOutput) -> Void)
    // sourcery:end
}

/// Will build carthage in the .build folder if not installed
public struct CarthageBuilder: CarthageBuilderProtocol, AutoGenerateProtocol
{
    public typealias SyncOutput = () throws -> [String]

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let highway: HighwayProtocol
    private let dispatchGroup: DispatchGroup
    private let queue: HighwayDispatchProtocol

    // MARK: - Init

    public init(
        terminal: TerminalProtocol,
        signPost: SignPostProtocol,
        highway: HighwayProtocol,
        dispatchGroup: DispatchGroup,
        queue: HighwayDispatchProtocol
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.highway = highway
        self.dispatchGroup = dispatchGroup
        self.queue = queue
    }

    // MARK: - Public Funtions

    public func attempt(_ async: @escaping (@escaping CarthageBuilder.SyncOutput) -> Void)
    {
        dispatchGroup.enter()
        queue.async
        {
            do
            {}
            catch
            {
                async { throw HighwayError.highwayError(atLocation: pretty_function(), error: error) }
            }
        }
    }

    // MARK: - Private Functions
}
