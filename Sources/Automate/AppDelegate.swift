//
//  AppDelegate.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import os
import Arguments

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    enum Error: Swift.Error {
        case noWorkerCommandFoundInArguments
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        do {
            try determineIfRunFromCommandLine()
        } catch Error.noWorkerCommandFoundInArguments {
            os_log("%@", type:.debug, "💁🏻‍♂️ Starting without arguments.\nYou can provice arguments prefixed with * \(Worker.commandPrefix) and possible workers\n\(Worker.allCases())")
        } catch {
            os_log("%@", type:.error, "command line caused error \(error)")
        }
    }
    
   
    // MARK: - Command Line
    
    private func determineIfRunFromCommandLine() throws {
        
        // 1. Check if run from command line
        
        
        let workers: [Worker] = CommandLine.arguments
            .filter { $0.hasPrefix(Worker.commandPrefix) }
            .map { $0.replacingOccurrences(of: Worker.commandPrefix, with: "")}
            .compactMap { Worker(rawValue: $0) }
        
        guard workers.count > 0 else {
            throw Error.noWorkerCommandFoundInArguments
        }
        
        os_log("%@", type:.debug, "loaded with arguments prefixed with <🤖command:>\n \(workers.map { $0.rawValue }.joined(separator: "\n"))\n")

        // 3. Find worker for the task
        
        for worker in workers {
            
            switch worker {
            case .sourcery:
               let worker = try AutomateSourceryWorker()
               let output = try worker.attempt()
               os_log("%@", type:.debug, "Sourcery ran with output:\n \(output.joined(separator: "\n"))")
            }
        }
        
        // 4. execute the task as if button was pressed
    }

}

