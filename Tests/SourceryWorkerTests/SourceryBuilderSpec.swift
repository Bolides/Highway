//
//  SourceryBuilderSpec.swift
//  SourceryWorkerTests
//
//  Created by Stijn on 28/02/2019.
//

import Errors
import Nimble
import Quick
import SignPostMock
import TerminalMock
import ZFile
import ZFileMock

import SourceryWorker

class SourceryBuilderSpec: QuickSpec
{
    override func spec()
    {
        pending("⚠️  SourceryBuilder spec are temporarily disabled")
        {
            var sut: SourceryBuilder?

            var terminal: TerminalProtocolMock!
            var disk: DependencyProtocolMock!
            var signPost: SignPostProtocolMock!
            var srcRootFolder: FolderProtocolMock!
            var sourceryExecutableFolder: FolderProtocolMock!
            var sourceryExecutableFile: FileProtocolMock!

            beforeEach
            {
                srcRootFolder = try! FolderProtocolMock()
                disk = DependencyProtocolMock()
                disk.srcRootReturnValue = srcRootFolder

                sourceryExecutableFile = try! FileProtocolMock()
                sourceryExecutableFolder = try! FolderProtocolMock()
                sourceryExecutableFolder.fileNamedClosure = { _ in
                    sourceryExecutableFile
                }

//                disk.underlyingCarthage = Disk.Carthage(
//                    checkouts: try! FolderProtocolMock(),
//                    sourcery: sourceryExecutableFolder
//                )
                terminal = TerminalProtocolMock()
                signPost = SignPostProtocolMock()

                expect
                {
                    sut = SourceryBuilder(
                        dependencyService: DependencyServiceProtocolMock(),
                        terminal: terminal,
                        signPost: signPost
                    )
                }.toNot(throwError())
            }

            context("no sourcery build")
            {
                beforeEach
                {
                    var throwCount = 0
                    sourceryExecutableFolder.subfolderNamedClosure = { _ in

                        guard throwCount == 0 else
                        {
                            // Fake success file after faked build
                            return sourceryExecutableFolder
                        }

                        throwCount += 1

                        throw ZFile.FileSystem.Item.PathError.invalid("mocking out build of sourcery")
                    }

                    // Faking build sourcery success
                    terminal.runProcessClosure = { _ in [""] }

                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())
                }

                it("builds sourcery")
                {
                    expect(terminal.runProcessCalled) == true
                }

                it("signpost missing build to verbose")
                {
                    expect { signPost.verboseCalled } == true
                }
            }

            context("sourcery has build")
            {
                beforeEach
                {
                    sourceryExecutableFolder.subfolderNamedClosure = { _ in
                        sourceryExecutableFolder
                    }

                    expect { try sut?.attemptToBuildSourceryIfNeeded() }.toNot(throwError())
                }

                it("does not build sourcery")
                {
                    expect(terminal.runProcessCalled) == false
                }

                it("NO sign missing build to verbose")
                {
                    expect { signPost.verboseCalled } == false
                }
            }
        }
    }
}
