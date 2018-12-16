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

    lazy var signPost: HighwaySignpostProtocol = HighwaySignpost.shared
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            signPost.log("Sourcery ran with output:\n \(try AutomateSourceryWorker().attempt().joined(separator: "\n"))")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
}

