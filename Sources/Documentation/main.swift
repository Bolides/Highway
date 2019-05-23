//
//  main.swift
//  Highway
//
//  Created by Stijn Willems on 22/05/2019.
//

import DocumentationLibrary
import Errors
import Foundation
import Highway
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

    try documentation.attemptJazzyDocs(in: srcRoot, for: dump)
    signPost.message("\(pretty_function()) ✅")
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
