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
import HighwayDispatchMock

class SourceryWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("SourceryWorker") {
            
            
            context("Static properties unchanged") {
                
                it("text replacements correnct") {
                    expect(SourceryWorker.mockableInline) == "// highway:inline:"
                    expect(SourceryWorker.mockableEnd) == "// highway:end"
                    expect(SourceryWorker.protocolGeneratableInline) == "// sourcery:inline:"
                    expect(SourceryWorker.protocolGeneratalbeEnd) == "// sourcery:end"
                }
            }
            
            var sut: SourceryWorker?
            
            var sourcery: SourceryProtocolMock!
            var terminalWorker: TerminalWorkerProtocolMock!
            var signPost: SignPostProtocolMock!
            var queue: HighwayDispatchProtocolMock!
            
            beforeEach {
                
                sourcery = SourceryProtocolMock()
                terminalWorker = TerminalWorkerProtocolMock()
                signPost = SignPostProtocolMock()
                queue =  HighwayDispatchProtocolMock()
                queue.asyncSyncClosure = { $0() }
                
                expect {
                    sut = try SourceryWorker(
                        sourcery: sourcery,
                        terminalWorker:terminalWorker,
                        signPost: signPost,
                        queue: queue
                    )
                }.toNot(throwError())
               
            }
            
            it("sut should be a valid SourceryWorker") {
                expect(sut).toNot(beNil())
            }
            
            pending("🚨 should have a result") {
                var result: [String]?
                var _error: Swift.Error?
                
                sut?.attempt { _result in
                    do { result = try _result() } catch {
                        _error = error
                    }
                }
                
                expect(_error).toNot(beNil())
                expect(signPost.verboseCalled).toEventually(beTrue())
            }
        }
    }
}
