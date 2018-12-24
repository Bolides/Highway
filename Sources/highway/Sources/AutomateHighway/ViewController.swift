//
//  ViewController.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import os
import Terminal
import SignPost
import SourceryWorker

class ViewController: NSViewController {

    lazy var signPost: SignPostProtocol = SignPost.shared
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            _ = try AutomateHighwaySourceryWorker(sourceryFolderWorkerType: SourceryFolderWorker.self).attempt()
            signPost.success("💁🏻‍♂️ Sourcery finished ✅.")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
}

