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
                
                terminal = TerminalWorkerProtocolMock()
                signPost = SignPostProtocolMock()
                
                expect {
                    sut = try SourceryBuilder(
                        terminalWorker: terminal,
                        disk: disk,
                        signPost: signPost
                    )
                }.toNot(throwError())
                
                sourceryExecutableFile = try! FileProtocolMock()
                sourceryExecutableFolder = try! FolderProtocolMock()
                sourceryExecutableFolder.fileNamedClosure = { path in
                    return sourceryExecutableFile
                }
            }
            
            context("no sourcery build") {
                
                beforeEach {
                    srcRootFolder.subfolderNamedClosure  = { path in
                        throw ZFile.FileSystem.Item.PathError.invalid("mocking out build of sourcery")
                    }
                    
                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())

                }
                
                it("NO sign missing build to verbose") {
                    expect { signPost.verboseCalled } == false
                }
                
            }
            
            context("sourcery has build") {
                
                beforeEach {
                    srcRootFolder.subfolderNamedClosure  = { path in
                        return sourceryExecutableFolder
                    }
                    
                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())
                    
                }
                
                it("NO sign missing build to verbose") {
                    expect { signPost.verboseCalled } == false
                }
                
            }
            
        }
    }
}
