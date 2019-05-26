
import Arguments
import Errors
import Foundation
import Git
import HighwayDispatch
import HighwayLibrary
import SignPost
import SourceryWorker
import Terminal
import ZFile

// MARK: - PREPARE

let highwayRunner: HighwayRunner!
let dispatchGroup: HWDispatchGroupProtocol = DispatchGroup()
let signPost = SignPost.shared

// MARK: - RUN on bitrise for PR

let dependencyService: DependencyServiceProtocol!

do
{
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    dependencyService = DependencyService(in: srcRoot)

    // Swift Package

    let dumpService = DumpService(swiftPackageFolder: srcRoot)
    let package = try Highway.package(for: srcRoot, dependencyService: dependencyService, dumpService: dumpService)

    let sourceryBuilder = SourceryBuilder(dependencyService: dependencyService)
    let highway = try Highway(package: package, dependencyService: dependencyService, sourceryBuilder: sourceryBuilder, gitHooksPrePushExecutableName: "HWSetup")

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)

    highwayRunner.runSourcery(handleSourceryOutput)

    dispatchGroup.notifyMain
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        dispatchGroup.wait()
        highwayRunner.runTests(handleTestOutput)
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
        signPost.error("🚀 \(HighwayRunner.self) has \(errors.count) ❌")

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
