//
//  ViewController.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import os

class ViewController: NSViewController {

    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            let worker = try AutomateSourceryWorker()
            let output = try worker.attempt()
            os_log("%@", type:.debug, "Sourcery ran with output:\n \(output.joined(separator: "\n"))")
        } catch {
            os_log(.error, "❌\n %@\n", "\(error)")
        }
    }
    
}

