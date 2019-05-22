//
//  main.swift
//  Highway
//
//  Created by Stijn Willems on 22/05/2019.
//

import DocumentationLibrary
import Errors
import Foundation
import SignPost
import ZFile

let signPost = SignPost.shared
let documentation = DocumentationWorker()

do
{
    signPost.message("\(pretty_function()) ...")
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()

    try documentation.attemptJazzyDocs(in: srcRoot)
    signPost.message("\(pretty_function()) ✅")
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
