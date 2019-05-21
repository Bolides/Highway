import Errors
import Foundation
import SecretsLibrary
import SignPost
import Terminal
import ZFile

let secretWorker = SecretsWorker()
let signPost = SignPost.shared
let terminal = Terminal.shared

do
{
    signPost.message("\(pretty_function()) ...")

    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

//    try secretWorker.attemptHideSecrets(in: srcRoot)
    let output = try secretWorker.attemptHideSecretsWithgpg(in: srcRoot)
    signPost.message(output.joined(separator: "\n"))
    exit(EXIT_SUCCESS)
}
catch
{
    signPost.error("\(error)")
    signPost.message("\(pretty_function()) ✅")
    exit(EXIT_FAILURE)
}
