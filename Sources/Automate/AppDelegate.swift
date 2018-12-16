//
//  AppDelegate.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import os
import Arguments
import Terminal

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var signPost: HighwaySignpostProtocol = HighwaySignpost.shared

    // MARK: - ERROR
    
    enum Error: Swift.Error {
        case noWorkerCommandFoundInArguments
    }
    
    // MARK: - APPLIATION LIFECYCLE
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        do {
            try determineIfRunFromCommandLine()
        } catch Error.noWorkerCommandFoundInArguments {
            signPost.log("💁🏻‍♂️ Starting without arguments.\nYou can provice arguments prefixed with * \(Worker.commandPrefix) and possible workers\n\(Worker.allCases())")
        } catch {
            signPost.error("❌ running command caused error:\n\(error)\n")
            fatalError()
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
        
        signPost.log("loaded with arguments prefixed with <🤖command:>\n \(workers.map { $0.rawValue }.joined(separator: "\n"))\n")

        // 3. Find worker for the task
        
        for worker in workers {
            
            switch worker {
            // 4. execute the task as if button was pressed
            case .sourcery:
               let worker = try AutomateSourceryWorker()
               let output = try worker.attempt()
               signPost.log("💁🏻‍♂️ Sourcery ran with output:\n \(output.joined(separator: "\n"))")
            }
            
        }
        
    }

}

