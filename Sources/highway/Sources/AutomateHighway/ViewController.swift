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

class ViewController: NSViewController {

    lazy var signPost: SignPostProtocol = SignPost.shared
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            _ = try AutomateHighwaySourceryWorker().attempt()
            signPost.success("💁🏻‍♂️ Sourcery finished ✅.")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
}

