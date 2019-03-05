//
//  SourceryBuilderSpec.swift
//  SourceryWorkerTests
//
//  Created by Stijn on 28/02/2019.
//

import Quick
import Nimble
import ZFileMock
import TerminalMock
import ArgumentsMock
import SignPostMock
import Errors
import ZFile
@testable import Arguments

import SourceryWorker

class SourceryBuilderSpec: QuickSpec {
    
    override func spec() {
        
        describe("SourceryBuilder") {
            
            var sut: SourceryBuilder?
            
            var terminal: TerminalWorkerProtocolMock!
            var disk: DiskProtocolMock!
            var signPost: SignPostProtocolMock!
            var srcRootFolder: FolderProtocolMock!
            var sourceryExecutableFolder: FolderProtocolMock!
            var sourceryExecutableFile: FileProtocolMock!
            
            beforeEach {
                
                srcRootFolder = try! FolderProtocolMock()
                disk = DiskProtocolMock()
                disk.srcRoot = srcRootFolder
                
                sourceryExecutableFile = try! FileProtocolMock()
                sourceryExecutableFolder = try! FolderProtocolMock()
                sourceryExecutableFolder.fileNamedClosure = { path in
                    return sourceryExecutableFile
                }
                
                disk.underlyingCarthage = Disk.Carthage(
                    checkouts: try! FolderProtocolMock(),
                    sourcery: sourceryExecutableFolder
                )
                terminal = TerminalWorkerProtocolMock()
                signPost = SignPostProtocolMock()
                
                expect {
                    sut = try SourceryBuilder(
                        terminalWorker: terminal,
                        disk: disk,
                        signPost: signPost
                    )
                }.toNot(throwError())
                
                
            }
            
            context("no sourcery build") {
                
                beforeEach {
                    var throwCount = 0
                    sourceryExecutableFolder.subfolderNamedClosure  = { path in
                        
                        guard throwCount == 0 else {
                            
                            // Fake success file after faked build
                            return sourceryExecutableFolder
                        }
                        
                        throwCount += 1

                        throw ZFile.FileSystem.Item.PathError.invalid("mocking out build of sourcery")
                    }
                    
                    // Faking build sourcery success
                    terminal.runProcessClosure = { _ in return [""] }
                    
                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())

                }
                
                it("builds sourcery") {
                    expect(terminal.runProcessCalled) == true
                }
                
                it("signpost missing build to verbose") {
                    expect { signPost.verboseCalled } == true
                }
                
            }
            
            context("sourcery has build") {
                
                beforeEach {
                    sourceryExecutableFolder.subfolderNamedClosure  = { path in
                        return sourceryExecutableFolder
                    }
                    
                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())
                    
                }
                
                it("does not build sourcery") {
                    expect(terminal.runProcessCalled) == false
                }
                
                it("NO sign missing build to verbose") {
                    expect { signPost.verboseCalled } == false
                }
                
            }
            
        }
    }
}
