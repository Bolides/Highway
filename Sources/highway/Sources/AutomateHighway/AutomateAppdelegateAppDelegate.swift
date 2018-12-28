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
import SignPost
import SourceryWorker
import Deliver
import ZFile

@NSApplicationMain
class AutomateAppdelegateAppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var signPost: SignPostProtocol = SignPost.shared

    // MARK: - Application LifeCycle
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        do {
            try determineIfRunFromCommandLine()
        } catch ArgumentsWorker.Error.noWorkerCommandFoundInArguments {
            signPost.message("💁🏻‍♂️ Starting without arguments.\nYou can provice arguments prefixed with * \(Worker.commandPrefix) and possible workers\n\(Worker.allCases())")
        } catch {
            signPost.error("❌ running command caused error:\n\(error)\n")
            NSApplication.shared.terminate(self)
        }
        
        tempGenerateJWTToken()
    }
    
   
    private func tempGenerateJWTToken() {
        
        //: # Cupertino JWT
        
        do {
            let srcRoot = try SourceryFolderWorker(bundle: Bundle.main).srcRoot.folder

            // Get content of the .p8 file
            let p8 = try srcRoot.file(named: "/Sources/AutomateHighway/AuthKey_VV7NT37UVU.p8")
            let worker = try JWTTokenWorker(p8KeyFile: p8)
            signPost.message("💁🏻‍♂️ JWT token \(worker.token)")
            
        } catch {
            signPost.error("⚠️  \(error)")
        }
    }
    
    // MARK: - Command Line
    
    private func determineIfRunFromCommandLine() throws {
        
        // 1. Check if run from command line
        
        let argumentsWorker = try ArgumentsWorker()
        signPost.message("💁🏻‍♂️ loaded with arguments prefixed with <🤖command:>\n \(argumentsWorker.workers.map { $0.rawValue }.joined(separator: "\n"))\n")

        // 3. Find worker for the task
        
        try argumentsWorker.workers.forEach {
            
            switch $0 {
            // 4. execute the task as if button was pressed
            case .sourcery:
                let worker = try AutomateHighwaySourceryWorker(sourceryFolderWorkerType: SourceryFolderWorker.self)
               _ = try worker.attempt()
               signPost.success("💁🏻‍♂️ Sourcery finished ✅.")
            }
            
        }
        
        // 5. Terminate After success

        NSApplication.shared.terminate(self)
    }

}

