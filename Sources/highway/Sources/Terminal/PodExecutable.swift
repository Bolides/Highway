//
//  PodExecutable.swift
//  Terminal
//
//  Created by Stijn on 27/02/2019.
//

import Arguments
import Foundation
import SignPost
import ZFile

public struct PodExecutable: ArgumentExecutableProtocol
{
    private let signPost: SignPostProtocol

    public init(signPost: SignPostProtocol = SignPost.shared)
    {
        self.signPost = signPost
    }

    public func arguments() throws -> Arguments
    {
        return Arguments(arrayLiteral: "install")
    }

    public func executableFile() throws -> FileProtocol
    {
        let homeFolder = FileSystem.shared.homeFolder
        signPost.verbose("Searching for pod command in folder \(homeFolder)")
        let podfile = try homeFolder.file(named: ".rbenv/shims/pod")
        signPost.verbose("Using pod \(podfile)")
        return podfile
    }
}
