
import Arguments
import Errors
import Foundation
import GitHooks
import Highway
import SignPost
import SourceryWorker
import SwiftFormatWorker
import Terminal
import XCBuild
import ZFile

// MARK: - PREPARE

let highwayRunner: HighwayRunner!
let dispatchGroup = DispatchGroup()
let signPost = SignPost.shared

// MARK: - RUN

let dependencyService: DependencyServiceProtocol!

do
{
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    dependencyService = DependencyService(in: srcRoot)

    // Swift Package

    let dumpService = DumpService(swiftPackageFolder: srcRoot)
    let rootPackage = try Highway.package(for: srcRoot, dependencyService: dependencyService, dumpService: dumpService)

    let sourceryBuilder = SourceryBuilder(dependencyService: dependencyService)
    let highway = try Highway(package: (package: rootPackage, executable: "HWSetup"), dependencyService: dependencyService, sourceryBuilder: sourceryBuilder)

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)

//    // Githooks

    try highwayRunner.addGithooksPrePush()

    highwayRunner.runSourcery(handleSourceryOutput)

    dispatchGroup.notify(queue: DispatchQueue.main)
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        dispatchGroup.wait()
        highwayRunner.runTests(handleTestOutput)
        dispatchGroup.wait()
        highwayRunner.runSwiftPackageGenerateXcodeProject(handleSwiftPackageGenerateXcodeProject)
        dispatchGroup.wait()
        guard let errors = highwayRunner.errors, errors.count > 0 else
        {
            signPost.message("🚀 \(HighwayRunner.self) ✅")
            exit(EXIT_SUCCESS)
        }
        signPost.message("🚀 \(HighwayRunner.self) has \(errors.count) ❌")

        for error in errors.enumerated()
        {
            let message = """
            ❌ \(error.offset + 1)
            
                \(error.element)
            
            ---
            
            """
            signPost.error(message)
        }
        exit(EXIT_FAILURE)
    }
    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
