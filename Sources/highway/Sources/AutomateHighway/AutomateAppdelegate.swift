//
//  AppDelegate.swift
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

@NSApplicationMain
class AutomateAppdelegate: NSObject, NSApplicationDelegate
{
    lazy var signPost: SignPostProtocol = SignPost.shared

    var sourceryWorker: AutomateHighwaySourceryWorkerProtocol?
    var swiftFormatWorker: SwiftFormatWorkerProtocol?

    // MARK: - Application LifeCycle

    func applicationDidFinishLaunching(_: Notification)
    {
        do
        {
            let disk = try Disk()
            sourceryWorker = try AutomateHighwaySourceryWorker(disk: disk)
            swiftFormatWorker = try SwiftFormatWorker(folderToFormatRecursive: try disk.srcRoot.subfolder(named: "Sources/Highway/Sources"))

            try determineIfRunFromCommandLine()
        }
        catch ArgumentsWorker.Error.noWorkerCommandFoundInArguments
        {
            signPost.message("💁🏻‍♂️ Starting without arguments.\nYou can provice arguments prefixed with * \(Worker.commandPrefix) and possible workers\n\(Worker.allCases.map { "\n*\($0)" })")
        }
        catch
        {
            signPost.error("❌ running command caused error:\n\(error)\n")
            NSApplication.shared.terminate(self)
        }
    }

    // MARK: - Command Line

    private func determineIfRunFromCommandLine() throws
    {
        // 1. Check if run from command line

        let argumentsWorker = try ArgumentsWorker()
        signPost.verbose("💁🏻‍♂️ loaded with arguments prefixed with <🤖command:>\n \(argumentsWorker.workers.map { $0.rawValue }.joined(separator: "\n"))\n")

        // 3. Find worker for the task

        argumentsWorker.workers.forEach
        { command in
            switch command {
            // 4. execute the task as if button was pressed
            case .sourcery:
                sourceryWorker?.attempt
                { [weak self] syncOutput in
                    do
                    {
                        _ = try syncOutput()
                        self?.signPost.success("💁🏻‍♂️ \(command) finished ✅.")
                        // 5. Terminate After success

                        NSApplication.shared.terminate(self)
                    }
                    catch
                    {
                        self?.signPost.error("❌ \(command)\n \(error)\n❌")
                    }
                }
            case .swiftformat:

                swiftFormatWorker?.attempt
                { [weak self] syncOutput in
                    do
                    {
                        _ = try syncOutput()
                        self?.signPost.success("💁🏻‍♂️ \(command) finished ✅.")
                        // 5. Terminate After success

                        NSApplication.shared.terminate(self)
                    }
                    catch
                    {
                        self?.signPost.error("❌ \(command)\n \(error)\n❌")
                    }
                }
            }
        }
    }
}
