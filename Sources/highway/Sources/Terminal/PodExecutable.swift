//
//  PodExecutable.swift
//  Terminal
//
//  Created by Stijn on 27/02/2019.
//

import Arguments
import Foundation
import SignPost
import Task
import ZFile

public struct PodExecutable: ArgumentExecutableProtocol
{
    private let signPost: SignPostProtocol
    private let system: SystemProtocol

    public init(
        system: SystemProtocol,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.system = system
        self.signPost = signPost
    }

    public func arguments() throws -> Arguments
    {
        return Arguments(arrayLiteral: "install")
    }

    public func executableFile() throws -> FileProtocol
    {
        var podfile: FileProtocol!

        do
        {
            let homeFolder = FileSystem.shared.homeFolder
            signPost.verbose("Searching for pod command in folder \(homeFolder)")
            podfile = try homeFolder.file(named: ".rbenv/shims/pod")
        }
        catch
        {
            signPost.message("Pod not found, looking on system")
            let systemTask = try system.task(named: "pod")
            podfile = systemTask.executable
        }

        signPost.verbose("found pod at \(String(describing: podfile))")

        return podfile
    }
}
