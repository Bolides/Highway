

import Errors
import Foundation

import HighwayDispatch
import HighwayLibrary
import SecretsLibrary
import SignPost
import SourceryWorker
import Terminal
import ZFile

// MARK: - PREPARE

let highwayRunner: HighwayRunner!
let dispatchGroup: HWDispatchGroupProtocol = DispatchGroup()
let signPost = SignPost.shared

// MARK: - RUN

let dependencyService: DependencyServiceProtocol!

do
{
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    dependencyService = DependencyService(in: srcRoot)

    // Swift Package

    let dumpService = DumpService(swiftPackageFolder: srcRoot)
    let package = try Highway.package(for: srcRoot, dependencyService: dependencyService, dumpService: dumpService)

    let sourceryBuilder = SourceryBuilder(dependencyService: dependencyService)
    let highway = try Highway(package: package, dependencyService: dependencyService, sourceryBuilder: sourceryBuilder, gitHooksPrePushExecutableName: "PR")

    let secrets = SecretsWorker.shared
    let output = try secrets.revealSecrets(in: srcRoot)
    signPost.message(output.joined(separator: "\n"))

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)

    try highwayRunner.addGithooksPrePush()
    try highwayRunner.checkIfSecretsShouldBeHidden(in: srcRoot)

    highwayRunner.runSourcery(handleSourceryOutput)

    dispatchGroup.notifyMain
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        dispatchGroup.wait()
        highwayRunner.runTests(handleTestOutput)
        dispatchGroup.wait()
        highwayRunner.runSwiftPackageGenerateXcodeProject(handleSwiftPackageGenerateXcodeProject)
        dispatchGroup.wait()
        guard let errors = highwayRunner.errors, errors.count > 0 else
        {
            let git = GitTool()

            do
            {
                guard try git.isClean() else
                {
                    signPost.error("changes not commited")
                    signPost.message("🚀 \(HighwayRunner.self) ❌")
                    exit(EXIT_FAILURE)
                }
            }
            catch
            {
                signPost.error("\(error)")
                signPost.message("🚀 \(HighwayRunner.self) ❌")
                exit(EXIT_FAILURE)
            }

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