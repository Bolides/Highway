import Errors
import GitSecretsLibrary
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

    try secretWorker.attemptHideSecrets(in: srcRoot)
}
catch
{
    signPost.error("\(error)")
    signPost.message("\(pretty_function()) ✅")
}
