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
                    expect(SourceryWorker.mockableInline) == "/// sourcery:inline:"
                    expect(SourceryWorker.mockableEnd) == "/// sourcery:end"
                    expect(SourceryWorker.protocolGeneratableInline) == "// sourcery:inline:"
                    expect(SourceryWorker.protocolGeneratalbeEnd) == "// sourcery:end"
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
               
                expect {
                    sut = try SourceryWorker(
                        sourcery: sourcery,
                        terminalWorker:terminalWorker,
                        signPost: signPost,
                        queue: queue
                    )
                }.toNot(throwError())
               
            }
            
            it("should") {
                
            }
        }
    }
}
