//
//  PodExecutable.swift
//  Terminal
//
//  Created by Stijn on 27/02/2019.
//

import Arguments
import Errors
import Foundation
import SignPost
import ZFile

public struct PodExecutable: ArgumentExecutableProtocol
{
    private let signPost: SignPostProtocol
    private let system: SystemExecutableProviderProtocol

    public init(
        system: SystemExecutableProviderProtocol = SystemExecutableProvider.shared,
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
            do
            {
                let homeFolder = FileSystem.shared.homeFolder
                signPost.message(".rbenv setup verification - Searching for pod command in folder \(homeFolder)")
                podfile = try homeFolder.file(named: ".rbenv/shims/pod")
            }
            catch
            {
                signPost.message("Pod not found, looking in all folders from PATH")

                signPost.verbose("PATH \n \(system.pathEnvironmentParser.urls.map { $0.path }.joined(separator: "\n")) \n")

                podfile = try system.executable(with: "pod")
            }

            signPost.message("found pod at \(String(describing: podfile))")
        }
        catch
        {
            throw "\(self) \(#function) \(error)"
        }

        return podfile
    }
}
