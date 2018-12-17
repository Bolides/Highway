//
//  HighwaySourceryWorker.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//

import Foundation
import SourceryAutoProtocols
import SourceryWorker
import os
import ZFile
import Terminal

protocol AutomateSourceryWorkerProtocol: AutoMockable {
    /// sourcery:inline:AutomateSourceryWorker.AutoGenerateProtocol

    func attempt() throws -> [String]
    /// sourcery:end
}

struct AutomateSourceryWorker: AutomateSourceryWorkerProtocol, AutoGenerateProtocol {
    
    private let worker: SourceryWorkerProtocol
    private let signpost: SignpostProtocol
   
    
    init(worker: SourceryWorkerProtocol? = nil, signpost: SignpostProtocol = Signpost.shared) throws {
        self.signpost = signpost
        
        guard worker == nil else {
            self.worker = worker!
            return
        }
        
        let currentFolder = FileSystem().currentFolder
        signpost.log("💁🏻‍♂️ Attempting Sourcery in folder\n \(currentFolder)\n")
        
        var sourcery: SourceryProtocol!
        
        do {
            let projectFolder = try currentFolder.parentFolder().parentFolder()
            sourcery = try AutomateSourceryWorker.sourceryFromFolders(projectFolder, signpost,  try projectFolder.subfolder(named: "Carthage"))
        } catch {
            signpost.log("💁🏻‍♂️ Not running in .build.nosync/Debug folder, trying to run from current folder.")
            sourcery = try AutomateSourceryWorker.sourceryFromFolders(currentFolder, signpost,  try currentFolder.subfolder(named: "Carthage"))
        }
        
        signpost.log("""
        🧙‍♂️ Sourcery will run from config file
        > \(sourcery.sourceryYMLFile.path)
            
        ```yml
        \(try sourcery.sourceryYMLFile.readAsString())
        ```
        
        """
        )
        
        self.worker = try SourceryWorker(sourcery: sourcery)
        
    }

    func attempt() throws -> [String] {
        return try worker.attempt()
    }
    
    // MARK: - PRIVATE
    
    private static func sourceryFromFolders(_ projectFolder: FolderProtocol, _ signpost: SignpostProtocol, _ carthageFolder: FolderProtocol) throws -> Sourcery {
        let sourcesFolders = try projectFolder.subfolder(named: "Sources")
        
        return try Sourcery(
            sourcesFolders: sourcesFolders,
            templateFolder: try Folder(relativePath: "Checkouts/template-sourcery/sources/stencil", to: carthageFolder),
            outputFolder: try sourcesFolders.subfolder(named: "AutoGeneratedCode"),
            sourceryAutoProtocolsFile: try sourcesFolders.file(named: "AutoGeneratedCode/SourceryAutoProtocols.swift"),
            sourceryYMLFile: try projectFolder.createFileIfNeeded(named: ".sourcery.yml")
        )
        
    }
}