//
//  GitHooksSpec.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

import Quick
import Nimble
import GitHooks

class GitHooksWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("GitHooksWorker") {
            
            var sut: GitHooksWorker?
            
            beforeEach {
                sut = GitHooksWorker()
            }
            
            pending("⚠️ GitHooksWorker") {
                
            }
        }
    }
}
