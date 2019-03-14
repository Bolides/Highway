
import Arguments
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

func handleSourceryOutput(_ output: @escaping SourceryWorker.SyncOutput) { do { _ = try output() } catch { signPost.error("\(error)") } }
func handleTestOutput(_ output: @escaping HighwayRunner.SyncTestOutput) { do { _ = try output() } catch { signPost.error("\(error)") } }
func handleSwiftformat(_ output: @escaping HighwayRunner.SyncSwiftformat) { do { try output() } catch { signPost.error("\(error)") } }

// MARK: - RUN

do
{
    signPost.message("🚀 \(HighwayRunner.self) ...")

    // Swift Package

    let highway = try Highway(srcRootDependencies: try DependencyService(folderType: Folder.self).dependency, highwaySetupProductName: "HWSetup", folderType: Folder.self)

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)

//    // Githooks

    try highwayRunner.addGithooksPrePush()

    highwayRunner.runSourcery(handleSourceryOutput)

    signPost.message("🧙🏻‍♂️ still running ... (this can take some time ☕️)")

    dispatchGroup.notify(queue: DispatchQueue.main)
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        dispatchGroup.wait()
        highwayRunner.runTests(handleTestOutput)
        dispatchGroup.wait()
        guard let errors = highwayRunner.errors, errors.count > 0 else
        {
            signPost.message("🚀 \(HighwayRunner.self) ✅")
            exit(EXIT_SUCCESS)
        }
        signPost.message("🚀 \(HighwayRunner.self) has \(errors.count) ❌")
        exit(EXIT_FAILURE)
    }
    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
