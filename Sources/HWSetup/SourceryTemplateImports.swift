//
//  SourceryTemplateImports.swift
//  HWSetup
//
//  Created by Stijn on 07/03/2019.
//

import Foundation
import Arguments
import SourceryWorker
import Errors

extension SwiftProduct {

    public func imports() throws -> Set<TemplatePrepend>
    {
        guard let product = HighwayProduct(rawValue: name) else {
            throw "\(self) \(#function) \(#line) error in \(#file) \n \(name) is not a valid Ha\n"
        }
        
        // Insert the target itself
        var importNames = AutomateHighwaySourceryWorker.commonImportAutoMockable
        importNames.insert(TemplatePrepend.Import(name: name))
        importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFile.rawValue))
        importNames.insert(TemplatePrepend.Import(name: VendorFramework.ZFileMock.rawValue))
        
        // If not the default, add a case and insert imports into importNames
        switch product
        {
        case .Task:
            importNames.insert(TemplatePrepend.Import(name: HighwayProduct.Arguments.rawValue))
            importNames.insert(TemplatePrepend.Import(name: HighwayProduct.SignPost.rawValue))
            
            return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
        case .Terminal, .XCBuild:
            importNames.insert(TemplatePrepend.Import(name: HighwayProduct.Arguments.rawValue))
            
            return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
        default:
            return Set([TemplatePrepend(name: importNames, template: Template.AutoMockable.rawValue)])
        }
    }
    enum VendorFramework: String, CaseIterable
    {
        case ZFile
        case ZFileMock
    }
    
    enum Template: String
    {
        case AutoMockable
    }
}
