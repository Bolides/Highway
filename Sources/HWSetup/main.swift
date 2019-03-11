
import Arguments
import Foundation
import GitHooks
import SignPost
import SwiftFormatWorker
import Terminal
import XCBuild

let automateSourceryWorker: HWSetupSourceryWorkerWorkerProtocol?
let disk: SwiftPackageDependenciesProtocol?
let swiftPackageDump: SwiftPackageDumpProtocol?
let signPost = SignPost.shared
let dispatchGroup = DispatchGroup()
let swiftFormatWorker: SwiftFormatWorkerProtocol
signPost.message("🚀 HWSetup ... ")
let terminal = TerminalWorker.shared

let githooks: GitHooksWorker?
do
{
    // Swift Package

    let swiftPackageDependencyService = try SwiftPackageDependencyService()
    disk = swiftPackageDependencyService.swiftPackage
    try swiftPackageDependencyService.writeToStubFile()

    let swiftPackageDumpService = try SwiftPackageDumpService(swiftPackageDependencies: disk!)
    swiftPackageDump = swiftPackageDumpService.swiftPackageDump
    try swiftPackageDumpService.writeToStubFile()

    // Githooks

    githooks = GitHooksWorker(swiftPackageDependencies: disk!, swiftPackageDump: swiftPackageDump!)

    // Setup Workers

    automateSourceryWorker = try HWSetupSourceryWorker(swiftPackageDependencies: disk!, dispatchGroup: dispatchGroup, swiftPackageDump: swiftPackageDump!)
    swiftFormatWorker = try SwiftFormatWorker(folderToFormatRecursive: try disk!.srcRoot().subfolder(named: "Sources"))

    let sourceryProducts = swiftPackageDump!.products.map { $0.name }.filter { !$0.hasSuffix("Mock") }
    signPost.message("🧙‍♂️ \(sourceryProducts.count) for \n\(sourceryProducts.enumerated().map { " \($0.offset + 1) \($0.element)" }.joined(separator: "\n"))\n ")

    try automateSourceryWorker?.attempt
    { asyncResult in
        do
        {
            let result = try asyncResult()
            signPost.verbose("\(result.joined(separator: "\n"))")
            dispatchGroup.leave()
        }
        catch
        {
            signPost.error("\(error)")
            dispatchGroup.leave()
            exit(EXIT_FAILURE)
        }
    }

    try githooks?.addPrePushToGitHooks()

    dispatchGroup.notify(queue: DispatchQueue.main)
    {
        signPost.message("🧹 swiftformat ... ")

        dispatchGroup.enter()
        swiftFormatWorker.attempt
        { syncSwiftformatOutput in
            do
            {
                try syncSwiftformatOutput()
                signPost.message("🧹 swiftformat ✅")
                dispatchGroup.leave()
            }
            catch
            {
                signPost.error("\(error)")
                dispatchGroup.leave()
                exit(EXIT_FAILURE)
            }
        }

        dispatchGroup.wait()
        signPost.message("🚀 HWSetup complete ...\n🧪 TESTING ... ")
        do
        {
            let task = try Task(commandName: "swift")
            task.arguments = Arguments(["test"])

            let testOutput = TestReport(output: try terminal.runProcess(task.toProcess))
            signPost.message("\(testOutput)")
            signPost.message("🚀 HWSetup ✅")
            exit(EXIT_SUCCESS)
        }
        catch
        {
            signPost.error("\(error)")
            exit(EXIT_FAILURE)
        }
    }
    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
