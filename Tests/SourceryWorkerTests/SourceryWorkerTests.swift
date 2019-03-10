//
//  SourceryWorkerTests.swift
//  SourceryWorkerTests
//
//  Created by Stijn on 15/12/2018.
//

import Quick
import Nimble
import SourceryWorker
import SourceryWorkerMock
import TerminalMock
import SignPostMock
import Foundation

class SourceryWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("SourceryWorker") {
            
            
            context("Static properties unchanged") {
                
                it("text replacements correnct") {
                    expect(SourceryWorker.mockableInline) == "/// highway:inline:"
                }
            }
            var sut: SourceryWorker?
            
            var sourcery: SourceryProtocolMock!
            var terminalWorker: TerminalWorkerProtocolMock!
            var signPost: SignPostProtocolMock!
            let queue: DispatchQueue = DispatchQueue.main
            
            beforeEach {
                
                sourcery = SourceryProtocolMock()
                terminalWorker = TerminalWorkerProtocolMock()
                signPost = SignPostProtocolMock()
                
                sut = SourceryWorker(
                    sourcery: sourcery,
                    terminalWorker:terminalWorker,
                    signPost: signPost,
                    queue: queue
                )
            }
            
            it("should") {
                
            }
        }
    }
}
