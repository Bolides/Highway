//
//  ViewController.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Cocoa
import ZFile
import SourceryWorker
import os

class ViewController: NSViewController {

    @IBAction func runSourcery(_ sender: NSButton) {
        do {
            try setupSourceryWorker()
        } catch {
            os_log(.error, "❌\n %@\n", "\(error)")
        }
    }
    
    // MARK: - Sourcery Setup
    
    private func setupSourceryWorker() throws {
        
        let currentFolder = FileSystem().currentFolder
        os_log(.debug, "💁🏻‍♂️ Running in folder\n %@\n", "\(currentFolder)")
        
        let projectFolder = try currentFolder.parentFolder().parentFolder()
        let carthageFolder = try projectFolder.subfolder(named: "Carthage")
        os_log(.debug, "💁🏻‍♂️ Carthage in folder\n %@\n", "\(carthageFolder)")
        
        let sourcesFolder = try projectFolder.subfolder(named: "Sources")
        os_log(.debug, "💁🏻‍♂️ Sources are in folder\n %@\n", "\(sourcesFolder)")
        
        let sourcery = try Sourcery(
            templateFolder: try Folder(relativePath: "Checkouts/template-sourcery/sources/stencil", to: carthageFolder),
            outputFolder: try sourcesFolder.subfolder(named: "🧙‍♂️/Mocks"),
            sourceFolder: sourcesFolder,
            sourceryAutoProtocolsFile: try sourcesFolder.file(named: "🧙‍♂️/AutoProtocols/SourceryAutoProtocols.swift")
        )
        
        let sourceryWorker = try SourceryWorker(sourcery: sourcery)
        
        os_log(.debug, "🧙‍♂️ Sourcery ran with output\n %@\n", "\(try sourceryWorker.attempt().joined(separator: "\n"))")
    }
}

