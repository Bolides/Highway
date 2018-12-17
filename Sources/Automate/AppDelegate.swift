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
    
    lazy var signPost: SignpostProtocol = Signpost.shared

    // MARK: - Application LifeCycle
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        do {
            try determineIfRunFromCommandLine()
        } catch ArgumentsWorker.Error.noWorkerCommandFoundInArguments {
            signPost.log("💁🏻‍♂️ Starting without arguments.\nYou can provice arguments prefixed with * \(Worker.commandPrefix) and possible workers\n\(Worker.allCases())")
        } catch {
            signPost.error("❌ running command caused error:\n\(error)\n")
            NSApplication.shared.terminate(self)
        }
    }
    
   
    // MARK: - Command Line
    
    private func determineIfRunFromCommandLine() throws {
        
        // 1. Check if run from command line
        
        let argumentsWorker = try ArgumentsWorker()
        signPost.log("💁🏻‍♂️ loaded with arguments prefixed with <🤖command:>\n \(argumentsWorker.workers.map { $0.rawValue }.joined(separator: "\n"))\n")

        // 3. Find worker for the task
        
        try argumentsWorker.workers.forEach {
            
            switch $0 {
            // 4. execute the task as if button was pressed
            case .sourcery:
               let worker = try AutomateSourceryWorker()
               _ = try worker.attempt()
               signPost.log("💁🏻‍♂️ Sourcery finished ✅.")
            }
            
        }
        
        // 5. Terminate After success

        NSApplication.shared.terminate(self)
    }

}

