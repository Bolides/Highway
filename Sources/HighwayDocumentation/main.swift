import DocumentationLibrary
import Errors
import Foundation
import SignPost
import Terminal
import ZFile

let terminal = Terminal.shared
let signPost = SignPost.shared

do
{
    signPost.message("\(pretty_function()) ...")
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    let documentation = DocumentationWorker()
    let products = try DumpService(swiftPackageFolder: srcRoot)
        .generateDump()
        .products
        .filter { !($0.name.hasSuffix("Mock") || $0.product_type == "executable") }

    let output = try documentation.attemptJazzyDocs(in: srcRoot, packageName: "Highway", for: products)
    signPost.message(output.joined(separator: "\n"))
    signPost.message("\(pretty_function()) ✅")
    exit(EXIT_SUCCESS)
}
catch
{
    signPost.error("\(error)")
    signPost.message("\(pretty_function()) ❌")
    exit(EXIT_FAILURE)
}
