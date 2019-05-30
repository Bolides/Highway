

import Errors
import Foundation
import Terminal
import HighwayLibrary

do
{
    try setupHighwayRunner()
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
