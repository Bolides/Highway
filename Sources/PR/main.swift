
import Errors
import Foundation
import HighwayLibrary
import Terminal

signPost.message("\(pretty_function()) ...")

do
{
    try setupHighwayRunner()

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
                    signPost.message("\(pretty_function()) ❌")
                    exit(EXIT_FAILURE)
                }
            }
            catch
            {
                signPost.error("\(error)")
                signPost.message("\(pretty_function()) ❌")
                exit(EXIT_FAILURE)
            }

            signPost.message("\(pretty_function()) ✅")
            exit(EXIT_SUCCESS)
        }

        for error in errors.enumerated()
        {
            let message = """
            ❌ \(error.offset + 1)
            
                \(error.element)
            
            ---
            
            """
            signPost.error(message)
        }
        signPost.error("\(pretty_function()) has \(errors.count) ❌")
        exit(EXIT_FAILURE)
    }
    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    signPost.error("\(pretty_function()) ❌")
    exit(EXIT_FAILURE)
}
