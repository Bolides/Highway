import Foundation

import Errors
import GitHooksLibrary
import SignPost
import Terminal
import ZFile

// MARK: - PREPARE

let signPost = SignPost.shared

do
{
    signPost.message("\(pretty_function()) ...")

    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    let githooks = GitHooksWorker(
        swiftPackageDependencies: try DependencyService(in: srcRoot).generateDependency(),
        swiftPackageDump: try DumpService(swiftPackageFolder: srcRoot).generateDump(),
        executableName: "PR"
    )

    try githooks.addPrePushToGitHooks()

    signPost.message("\(pretty_function()) ✅")
    exit(EXIT_SUCCESS)
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
