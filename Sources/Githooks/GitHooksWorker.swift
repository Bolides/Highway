//
//  GitHooksWorker.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol GitHooksWorkerProtocol: AutoMockable
{
    // sourcery:inline:GitHooksWorker.AutoGenerateProtocol
    static var prepushBashScript: String { get }

    func addPrePushToGitHooks() throws
    // sourcery:end
}

/// Adds a swift build step and runs HighWay Setup <#your executable#> from .git>Hooks/pre-push
public struct GitHooksWorker: GitHooksWorkerProtocol, AutoGenerateProtocol
{
    public static let prepushBashScript = """
    #!/bin/sh
    
    cd <#srcroot#>
    # Build setup executable
    if [ ! -f /tmp/foo.txt ]; then
        echo "<#executable name#>, not found - building for source"
        swift build --product <#executable name#> -c release --static-swift-stdlib
    fi
    
    # Execute the script
    ./.build/x86_64-apple-macosx10.10/release/<#executable name#>
    # Allow push on success
    """

    private let swiftPackageDependencies: SwiftPackageDependenciesProtocol
    private let signPost: SignPostProtocol
    private let swiftPackageDump: SwiftPackageDumpProtocol
    private let hwSetupExecutableProductName: String?

    /// Will take the first executable it can find in the swifPackage if you do not provice a HWSetup executable name
    public init(swiftPackageDependencies: SwiftPackageDependenciesProtocol, swiftPackageDump: SwiftPackageDumpProtocol, hwSetupExecutableProductName: String? = nil, signPost: SignPostProtocol = SignPost.shared)
    {
        self.swiftPackageDependencies = swiftPackageDependencies
        self.signPost = signPost
        self.swiftPackageDump = swiftPackageDump
        self.hwSetupExecutableProductName = hwSetupExecutableProductName
    }

    public func addPrePushToGitHooks() throws
    {
        signPost.message("💪🏻 \(GitHooksWorker.self) started ...")
        do
        {
            var executable: String!

            if let hwSetupExecutableProductName = hwSetupExecutableProductName
            {
                executable = hwSetupExecutableProductName
            }
            else
            {
                guard let _executable: SwiftProduct = (swiftPackageDump.products.first { $0.product_type == "executable" }) else
                {
                    throw "swift package should contain an executable"
                }
                executable = _executable.name
            }

            let script = GitHooksWorker.prepushBashScript
                .replacingOccurrences(of: "<#executable name#>", with: executable)
                .replacingOccurrences(of: "<#srcroot#>", with: try swiftPackageDependencies.srcRoot().path)

            var prePushFile: FileProtocol!
            do
            {
                prePushFile = try swiftPackageDependencies.gitHooks().file(named: "pre-push.sample")
                try prePushFile.rename(to: "pre-push", keepExtension: false)
            }
            catch
            {
                prePushFile = try swiftPackageDependencies.gitHooks().file(named: "pre-push")
            }

            try prePushFile.write(string: script)
            signPost.message("💪🏻\(prePushFile.path) \n contains script that will run before every push.")
            signPost.message("💪🏻 \(GitHooksWorker.self) ✅")
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(GitHooksWorker.self) \(#function) \(#line)", error: error)
        }
    }
}
