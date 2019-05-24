//
//  main.swift
//  Highway
//
//  Created by Stijn Willems on 22/05/2019.
//

import Arguments
import DocumentationLibrary
import Errors
import Foundation
import SignPost
import Terminal
import ZFile

let signPost = SignPost.shared
let documentation = DocumentationWorker()

do
{
    signPost.message("\(pretty_function()) ...")
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    // Swift Package

    let dumpService = DumpService(swiftPackageFolder: srcRoot)

    let dump = try dumpService.generateDump()
    let possibleNames = dump.products.map { $0.name }
    let arguments = CommandLine.arguments.filter { possibleNames.contains($0) }

    var products = dump.products.filter { arguments.contains($0.name) }

    if products.count == 0
    {
        signPost.message("Please add one of the product names \n \(possibleNames.joined(separator: "\n"))")
        signPost.message("\n🎺starting all ...\n")
        products = dump.products
    }

    let output = try documentation.attemptJazzyDocs(in: srcRoot, for: products)
    signPost.message("\(pretty_function()) \(output.joined(separator: "\n")) ✅")
    exit(EXIT_SUCCESS)
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
