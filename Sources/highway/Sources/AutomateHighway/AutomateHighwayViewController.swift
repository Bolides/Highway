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
import SwiftFormatWorker
import ZFile

class AutomateHighwayViewController: NSViewController {

    let folder = try! Folder(path: "/Users/doozmen/Documents/dooZ/Babylon/ios-babylon-application/Sources/Carthage/Checkouts/highway/Sources/highway")
    lazy var config = try! folder.file(named: ".swiftformat.md")
    
    lazy var signPost: SignPostProtocol = SignPost.shared
    
    lazy var swiftFormatWorker: SwiftFormatWorkerProtocol = SwiftFormatWorker(folderToFormat: folder, configFile: config)
    
    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            _ = try AutomateHighwaySourceryWorker(sourceryFolderWorkerType: SourceryFolderWorker.self).attempt()
            signPost.success("💁🏻‍♂️ Sourcery finished ✅.")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
    
    @IBAction func runSwiftFormat(_ sender: NSButton) {
        do {
            try swiftFormatWorker.attempt()
            signPost.success("💁🏻‍♂️ Sourcery finished ✅.")
        } catch {
            signPost.error( "❌\n \(error)\n")
        }
    }
}

