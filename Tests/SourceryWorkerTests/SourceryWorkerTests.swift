//
//  SourceryWorkerTests.swift
//  SourceryWorkerTests
//
//  Created by Stijn on 15/12/2018.
//

import Foundation
import HighwayDispatchMock
import Nimble
import Quick
import SignPostMock
import SourceryWorker
import SourceryWorkerMock
import TerminalMock
import ZFile
import ZFileMock
import ArgumentsMock

class SourceryWorkerSpec: QuickSpec
{
    override func spec()
    {
        describe("SourceryWorker")
        {
            context("Static properties unchanged")
            {
                it("text replacements correnct")
                {
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

            beforeEach
            {
                

                expect
                {
                    signPost = SignPostProtocolMock()
                    sourcery = try SourceryProtocolMock(productName: "Mock", swiftPackageDependencies: DependencyProtocolMock(), swiftPackageDump: DumpProtocolMock(), sourceryExecutable: try! FileProtocolMock(), signPost: signPost)
                    let sourcesFolder = try! FolderProtocolMock()
                    sourcery.sourcesFolders = [sourcesFolder]
                    let file = try! File(path: #file)
                    sourcery.executableFileReturnValue = file
                    sourcesFolder.makeFileSequenceRecursiveIncludeHiddenReturnValue = try! file.parent?.createSubfolderIfNeeded(withName: "MockTestOutput").makeFileSequence(recursive: false, includeHidden: true)
                    sourcery.outputFolder = sourcesFolder
                    sourcery.underlyingImports = Set([TemplatePrepend(name: Set([TemplatePrepend.Import(name: "MockImport")]), template: "MockTemplate")])
                    
                    terminalWorker = TerminalWorkerProtocolMock()
                    terminalWorker.terminalTaskReturnValue = ["mocked terminal output"]
                    
                    queue = HighwayDispatchProtocolMock()
                    queue.asyncSyncClosure = { $0() }
                    
                    sut = try SourceryWorker(
                        sourcery: sourcery,
                        terminalWorker: terminalWorker,
                        signPost: signPost,
                        queue: queue
                    )
                    return sut
                }.toNot(throwError())
            }

            it("sut should be a valid SourceryWorker")
            {
                expect(sut).toNot(beNil())
            }

            it("should have a result")
            {
                var result: SourceryWorker.SyncOutput?

                sut?.attempt { result = $0 }

                expect(result).toNot(beNil())
                expect { try result?() }.toNot(throwError())
            }
        }
    }
}
