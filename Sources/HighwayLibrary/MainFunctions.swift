//
//  MainFunctions.swift
//  HighwayLibrary
//
//  Created by Stijn Willems on 30/05/2019.
//

import Foundation
import HighwayDispatch
import SecretsLibrary
import SignPost
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

// MARK: - PREPARE

public var highwayRunner: HighwayRunner!
public var dispatchGroup: HWDispatchGroupProtocol = DispatchGroup()
public var signPost = SignPost.shared

public let srcRoot = try! File(path: #file).parentFolder().parentFolder().parentFolder()
public let sourcesFolder = try! srcRoot.subfolder(named: "Sources")
public let dependencyService = DependencyService(in: srcRoot)

/**
 Will setup highway global and can be used as a starting point in custom main.swift files
 
 - parameters:
     - gitHooksPrePushExecutableName: this is the name of the executable product in the swift package to
 - throws:
     - Errors from the Highway.Errors type. import Errors to inspect. Typically an error is wrapped in HighwayError enum HighwayError.highwayError(atLocation:error:). You can find the find the inderict error also with indirectError variable.
 
 */
public func setupHighwayRunner(gitHooksPrePushExecutableName: String = "PR") throws
{
    let dumpService = DumpService(swiftPackageFolder: srcRoot)
    let package = try Highway.package(for: srcRoot, dependencyService: dependencyService, dumpService: dumpService)

    let sourceryBuilder = SourceryBuilder(dependencyService: dependencyService)

    let swiftFormatWorker = try SwiftFormatWorker(
        folderToFormatRecursive: sourcesFolder,
        queue: Highway.queue,
        signPost: signPost
    )

    let highway = try Highway(
        package: package,
        dependencyService: dependencyService,
        sourceryBuilder: sourceryBuilder,
        gitHooksPrePushExecutableName: gitHooksPrePushExecutableName,
        swiftformat: swiftFormatWorker
    )

    let secrets = SecretsWorker.shared
    let output = try secrets.revealSecrets(in: srcRoot)
    signPost.message(output.joined(separator: "\n"))

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)
}
