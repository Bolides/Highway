//
//  ViewController.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import os
import Terminal

class ViewController: NSViewController {

    lazy var signPost: SignpostProtocol = Signpost.shared
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            _ = try AutomateSourceryWorker().attempt()
            signPost.log("💁🏻‍♂️ Sourcery finished ✅.")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
}

