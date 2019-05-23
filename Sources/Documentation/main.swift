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

    let products = dump.products.filter { !$0.name.hasSuffix("Mock") && $0.product_type != "executable" }
    let output = try documentation.attemptJazzyDocs(in: srcRoot, for: products)
    signPost.message("\(pretty_function()) \(output.joined(separator: "\n")) ✅")
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
