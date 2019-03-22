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
    static var defaultOptions: String { get }
    static var prepushBashScript: String { get }

    init(
        swiftPackageDependencies: DependencyProtocol,
        swiftPackageDump: DumpProtocol,
        hwSetupExecutableProductName: String?,
        options: String?,
        gitHooksFolder: FolderProtocol?,
        signPost: SignPostProtocol
    )
    func addPrePushToGitHooks() throws
    // sourcery:end
}

/// Adds a swift build step and runs HighWay Setup <#your executable#> from .git>Hooks/pre-push
public struct GitHooksWorker: GitHooksWorkerProtocol, AutoGenerateProtocol
{
    public static let defaultOptions: String = "-path $PATH"
    public static let prepushBashScript = """
    #!/bin/sh
    
    cd <#srcroot#>
    # Build setup executable
    if [ ! -f ./.build/x86_64-apple-macosx10.10/release/<#executable name#> ]; then
        echo "<#executable name#>, not found - building ..."
        swift build --product <#executable name#> -c release --static-swift-stdlib
        echo "<#executable name#>, not found - building ✅"
    fi
    
    # Execute the script
    ./.build/x86_64-apple-macosx10.10/release/<#executable name#> <#options#>
    """

    private let swiftPackageDependencies: DependencyProtocol
    private let signPost: SignPostProtocol
    private let swiftPackageDump: DumpProtocol
    private let hwSetupExecutableProductName: String?
    private let gitHooksFolder: FolderProtocol?
    private let options: String?

    /// Will take the first executable it can find in the swifPackage if you do not provice a HWSetup executable name
    // sourcery:includeInitInProtocol
    public init(
        swiftPackageDependencies: DependencyProtocol,
        swiftPackageDump: DumpProtocol,
        hwSetupExecutableProductName: String? = nil,
        options: String? = GitHooksWorker.defaultOptions,
        gitHooksFolder: FolderProtocol? = nil,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.swiftPackageDependencies = swiftPackageDependencies
        self.signPost = signPost
        self.swiftPackageDump = swiftPackageDump
        self.hwSetupExecutableProductName = hwSetupExecutableProductName
        self.gitHooksFolder = gitHooksFolder
        self.options = options
    }

    public func addPrePushToGitHooks() throws
    {
        signPost.message("👀 \(GitHooksWorker.self) ...")
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
                .replacingOccurrences(of: "<#options#>", with: options ?? "")

            var prePushFile: FileProtocol!
            let gitHooksFolder = self.gitHooksFolder == nil ? try swiftPackageDependencies.gitHooks() : self.gitHooksFolder!

            do
            {
                prePushFile = try gitHooksFolder.file(named: "pre-push.sample")
                try prePushFile.rename(to: "pre-push", keepExtension: false)
            }
            catch
            {
                prePushFile = try gitHooksFolder.file(named: "pre-push")
            }

            try prePushFile.write(string: script)
            signPost.verbose("👀 \(prePushFile.path) \n contains script that will run before every push.")
            signPost.message("👀 \(GitHooksWorker.self) ✅")
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(GitHooksWorker.self) \(#function) \(#line)", error: error)
        }
    }
}
