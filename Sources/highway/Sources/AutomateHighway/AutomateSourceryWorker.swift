//
//  DemoSourceryWorker.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//  Copyright © 2018 dooz. All rights reserved.
//

import Foundation
import SourceryAutoProtocols
import ZFile
import Terminal
import SourceryWorker
import SignPost

protocol DemoSourceryWorkerProtocol {
    //// sourcery:inline:DemoSourceryWorker.AutoGenerateProtocol
    
    func attempt() throws
    
    //// sourcery:end
}

struct AutomateHighwaySourceryWorker: DemoSourceryWorkerProtocol, AutoGenerateProtocol {
    
    private let signPost: SignPostProtocol
    private let workers: [SourceryWorkerProtocol]
    private static let commonImportAutoMockable = Set([
        TemplatePrepend.Import(name: "SourceryAutoProtocols"),
        TemplatePrepend.Import(name: "Foundation"),
        TemplatePrepend.Import(name: "os"),
    ])
    
    enum Target: String, CaseIterable {
        case Arguments
        case Deliver
        case Git
        case Keychain
        case SignPost
        case SourceryWorker
        case Terminal
        case Url
        case XCBuild
        case Errors
        case POSIX
        case Result
        case Task
        
        func imports() -> Set<TemplatePrepend> {
            
            // Insert the target itself
            var importNames = AutomateHighwaySourceryWorker.commonImportAutoMockable
            importNames.insert(TemplatePrepend.Import(name: self.rawValue))

            // If not the default, add a case and insert imports into importNames
            switch self {
            case .SourceryWorker:
                importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFile.rawValue))
                
                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            case .Task:
                importNames.insert(TemplatePrepend.Import(name: Target.Arguments.rawValue))
                importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFile.rawValue))
                importNames.insert(TemplatePrepend.Import(name: Target.SignPost.rawValue))
                
                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            case .Terminal:
                importNames.insert(TemplatePrepend.Import(name: Target.Arguments.rawValue))
                importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFile.rawValue))
                
                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            default:
                return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
            }
        }
    }
    
    enum VendorFramework: String, CaseIterable {
        case ZFile
    }
    
    enum Template: String {
        case AutoMockable
    }
    
    
    init(
        signPost: SignPostProtocol = SignPost.shared,
        sourceryFolderWorkerType: SourceryFolderWorkerProtocol.Type,
        workers: [SourceryWorkerProtocol]? = nil
        ) throws {
        self.signPost = signPost
        
        guard workers == nil else {
            self.workers = workers!
            return
        }
        
        var currentFolder: FolderProtocol = FileSystem().currentFolder
        var projectFolder = currentFolder
        var sourcesFolder = currentFolder
        var carthageFolder: FolderProtocol!
        
        do {
            
            signPost.message("💁🏻‍♂️ Running in current folder\n\(currentFolder)\n, If this is not the correct folder run AutomateZFile from the folder you want.\n AutomateZFile cannot work for derived data folder.")
            
            sourcesFolder = try projectFolder.subfolder(named: "Sources")
            carthageFolder = try projectFolder.parentFolder().subfolder(named: "Carthage")
            
        } catch {
            signPost.message("⚠️ Failed to runn from current folder at\(currentFolder.path) ⚠️")
            signPost.message("💁🏻‍♂️ Will try to run from folder defined in Info.plist with key \(SourceryFolderWorker.Key.scrRoot.rawValue) ...")
            
            currentFolder = try SourceryFolderWorker(bundle: Bundle.main).scrRoot.folder
            projectFolder = currentFolder
            
            sourcesFolder = try projectFolder.subfolder(named: "Sources")
            carthageFolder = try projectFolder.parentFolder().subfolder(named: "Carthage")
            
        }
        
        signPost.verbose("💁🏻‍♂️ Project in folder\n \(projectFolder.path)\n")
        signPost.verbose("💁🏻‍♂️ Sources in folder\n \(sourcesFolder.path)\n")
        signPost.verbose("💁🏻‍♂️ Carthage in folder\n \(sourcesFolder.path)\n")
        
        let highwayFolder =  projectFolder
        let templateFolder = try Folder(relativePath: "Checkouts/template-sourcery/sources/stencil", to: carthageFolder)
        let sourceryAutoProtocolFile = try highwayFolder.file(named: "/Sources/AutoGeneratedCode/SourceryAutoProtocols.swift")
        let autoGeneratedCodeFolder = try projectFolder.createSubfolderIfNeeded(withName: "sources/AutoGeneratedCode")
        
        let sourcerySequence = try Target.allCases.map { target in
            return try Sourcery(
                sourcesFolders: [sourcesFolder.subfolder(named: target.rawValue)],
                individualSourceFiles: nil,
                templateFolder: templateFolder,
                outputFolder: try autoGeneratedCodeFolder.createSubfolderIfNeeded(withName: target.rawValue),
                sourceryAutoProtocolsFile: sourceryAutoProtocolFile,
                sourceryYMLFile: try projectFolder.createFileIfNeeded(named: ".sourcery-\(target.rawValue).yml"),
                imports: target.imports()
            )
        }
        
        signPost.verbose("🧙‍♂️ Sourcery will run from config files ...")
        try sourcerySequence.forEach {
            signPost.verbose("""
                > \($0.sourceryYMLFile.path)
                
                ```yml
                \(try $0.sourceryYMLFile.readAsString())
                ```
                
                """
            )
        }
        
        self.workers =  try sourcerySequence.map { try SourceryWorker(sourcery: $0) }
        
    }
    
    // MARK: - Error
    
    enum Error: Swift.Error, CustomStringConvertible {
        var description: String { return "⚠️ You are running in derived data folder. See README of project on github doozMen/highway to change your project settings!"}
        
        case runningInDerivedDataFolder
        
    }
    
    // MARK: - Sourcery Setup
    
    func attempt() throws {
        return try workers.forEach {
            let output = try $0.attempt()
            signPost.verbose("\(output.joined(separator: "\n"))")
        }
    }
}
