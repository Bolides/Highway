//
//  ViewController.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Arguments
import Cocoa
import Errors
import os
import SignPost
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

class AutomateHighwayViewController: NSViewController
{
    lazy var signPost: SignPostProtocol = SignPost.shared
    lazy var highwayCommandLineArguments = HighwayCommandLineOption.Values()

    private var sourceryWorker: AutomateHighwaySourceryWorkerProtocol?
    private var swiftFormatWorker: SwiftFormatWorkerProtocol?

    @IBAction func runSourcery(_: NSButton)
    {
        do
        {
            if sourceryWorker == nil
            {
                sourceryWorker = try AutomateHighwaySourceryWorker(disk: try Disk())
            }

            sourceryWorker!.attempt
            { [weak self] syncOutput in
                do
                {
                    _ = try syncOutput()
                    self?.signPost.success("💁🏻‍♂️ \(#function) finished ✅.")
                }
                catch
                {
                    self?.signPost.error("❌ \(#function)\n \(error)\n❌")
                }
            }
        }
        catch
        {
            signPost.error("❌\n \(error)\n")
        }
    }

    @IBAction func runSwiftFormat(_: NSButton)
    {
        do
        {
            guard let relativeProjectPath = highwayCommandLineArguments.optionsAndValues[.srcroot] else
            {
                throw HighwayError.missingSrcroot(
                    message: """
                    You can provide the following options
                    \(HighwayCommandLineOption.allCases.map { $0.rawValue }.joined(separator: "\n"))
                    """,
                    function: "\(#function)"
                )
            }

            let projectFolder = try Folder(relativePath: relativeProjectPath)

            if swiftFormatWorker == nil
            {
                swiftFormatWorker = try SwiftFormatWorker(folderToFormatRecursive: try projectFolder.subfolder(named: "Sources/Highway/Sources"))
            }

            swiftFormatWorker!.attempt
            { [weak self] syncOutput in
                do
                {
                    try syncOutput()
                    self?.signPost.success("💁🏻‍♂️ \(#function) finished ✅.")
                }
                catch
                {
                    self?.signPost.error("❌ \(#function)\n \(error)\n❌")
                }
            }
        }
        catch
        {
            signPost.error("❌ \(#function) \n \(error)\n❌")
        }
    }
}
