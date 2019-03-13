
import Arguments
import Foundation
import GitHooks
import SignPost
import SwiftFormatWorker
import Terminal
import XCBuild
import Highway

let highwayRunner: HighwayRunner!
let dispatchGroup = DispatchGroup()
let signPost = SignPost.shared

do
{
    // Swift Package
    
    let highway = try Highway(srcRootDependencies: try DependencyService().dependency)
    
    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)
    
//    // Githooks
//
//    
//
//    // Setup Workers
//
//    let automateSourceryWorker = try HWSetupSourceryWorker(swiftPackageDependencies: srcRootDependencies!, dispatchGroup: dispatchGroup, swiftPackageDump: swiftPackageDump!)
//    let swiftFormatWorker = try SwiftFormatWorker(folderToFormatRecursive: try srcRootDependencies!.srcRoot().subfolder(named: "Sources"))
//
//    let sourceryProducts = swiftPackageDump!.products.map { $0.name }.filter { !$0.hasSuffix("Mock") }
//    signPost.message("🧙‍♂️ Sourcercy started for \(sourceryProducts.count) products \n\(sourceryProducts.enumerated().map { " \($0.offset + 1) \($0.element)" }.joined(separator: "\n"))\n ")
//
//    try automateSourceryWorker?.attempt
//    { asyncResult in
//        do
//        {
//            let result = try asyncResult()
//            signPost.verbose("\(result.joined(separator: "\n"))")
//            dispatchGroup.leave()
//        }
//        catch
//        {
//            signPost.error("\(error)")
//            dispatchGroup.leave()
//            exit(EXIT_FAILURE)
//        }
//    }
//
//    try githooks?.addPrePushToGitHooks()
//    signPost.message("🧙🏻‍♂️ still running ... (this can take some time ☕️)")
//    dispatchGroup.notify(queue: DispatchQueue.main)
//    {
//        signPost.message("🧹 swiftformat ... ")
//
//        dispatchGroup.enter()
//        swiftFormatWorker.attempt
//        { syncSwiftformatOutput in
//            do
//            {
//                try syncSwiftformatOutput()
//                signPost.message("🧹 swiftformat ✅")
//                dispatchGroup.leave()
//            }
//            catch
//            {
//                signPost.error("\(error)")
//                dispatchGroup.leave()
//                exit(EXIT_FAILURE)
//            }
//        }
//
//        dispatchGroup.wait()
//        signPost.message("🧪 swift test ... ")
//        do
//        {
//            let task = try Task(commandName: "swift")
//            task.arguments = Arguments(["test"])
//
//            let testOutput = TestReport(output: try terminal.runProcess(task.toProcess))
//            signPost.message("\(testOutput)")
//            signPost.message("🚀 HWSetup ✅")
//            exit(EXIT_SUCCESS)
//        }
//        catch let TerminalWorker.Error.unknownTask(errorOutput)
//        {
//            let testOutput = TestReport(output: errorOutput)
//            signPost.error("\(testOutput)")
//            signPost.error("🚀 HWSetup ❌")
//
//            exit(EXIT_FAILURE)
//        }
//        catch
//        {
//            signPost.error("\(error)")
//            signPost.error("🚀 HWSetup ❌")
//
//            exit(EXIT_FAILURE)
//        }
//    }
//    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
