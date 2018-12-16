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

    lazy var worker: AutomateSourceryWorkerProtocol? = { return try? AutomateSourceryWorker() }()
    lazy var signPost: HighwaySignpostProtocol = HighwaySignpost.shared
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            guard let output = try worker?.attempt() else {
                signPost.error("⚠️ \n Sourcery ran but no output or error!\n")
                return
            }
            signPost.log("Sourcery ran with output:\n \(output.joined(separator: "\n"))")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
}

