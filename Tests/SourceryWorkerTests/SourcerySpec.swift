//
//  SourcerySpec.swift
//  TerminalTests
//
//  Created by Stijn Willems on 11/03/2019.
//

import Foundation

import Arguments
import ArgumentsMock
import Errors
import Nimble
import Quick
import SourceryWorker
import SourceryWorkerMock
import Stub
import Terminal
import TerminalMock
import ZFile
import ZFileMock

class SourcerySpec: QuickSpec
{
    override func spec()
    {
        describe("Sourcery")
        {
            var sut: Sourcery?

            var swiftPackageDependencies: DependencyProtocol?
            var swiftPackageDump: DumpProtocol?
            var sourceryBuilder: SourceryBuilderProtocolMock!

            beforeSuite
            {
                sourceryBuilder = SourceryBuilderProtocolMock()

                // get real dependencies
                expect
                {
                    let srcroot = try File(path: #file).parentFolder().parentFolder().parentFolder()
                    FileManager.default.changeCurrentDirectoryPath(srcroot.path)
                    swiftPackageDependencies = try DependencyService(in: srcroot).generateDependency()
                    swiftPackageDump = try DumpService(swiftPackageFolder: srcroot).generateDump()

                    sourceryBuilder.dependenciesReturnValue = swiftPackageDependencies
                    return true
                }.toNot(throwError())
            }

            context("Arguments - add's correct imports via swift package dependencies")
            {
                context("highway products")
                {
                    func setup(for productName: String)
                    {
                        expect
                        {
                            guard let swiftPackageDump = swiftPackageDump, let swiftPackageDependencies = swiftPackageDependencies else { throw "swift package stuff missing" }

                            sut = try Sourcery(
                                productName: productName,
                                swiftPackageDependencies: swiftPackageDependencies,
                                swiftPackageDump: swiftPackageDump,
                                sourceryBuilder: sourceryBuilder
                            )
                            return sut
                        }.toNot(throwError())
                    }

                    context("Arguments")
                    {
                        beforeEach { setup(for: "Arguments") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Arguments,Foundation,SignPost,SourceryAutoProtocols,ZFile,ZFileMock"
                        }
                    }

                    context("Git")
                    {
                        beforeEach { setup(for: "Git") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("SignPost")
                    {
                        beforeEach { setup(for: "SignPost") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("SourceryWorker")
                    {
                        beforeEach { setup(for: "SourceryWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Arguments,Foundation,HighwayDispatch,SignPost,SourceryAutoProtocols,SourceryWorker,Terminal,TerminalMock,ZFile,ZFileMock"
                        }
                    }

                    context("Terminal")
                    {
                        beforeEach { setup(for: "Terminal") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Arguments,Foundation,SignPost,SourceryAutoProtocols,Terminal,ZFile,ZFileMock"
                        }
                    }

                    context("Url")
                    {
                        beforeEach { setup(for: "Url") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("XCBuild")
                    {
                        beforeEach { setup(for: "XCBuild") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Arguments,Foundation,SignPost,SourceryAutoProtocols,XCBuild,ZFile,ZFileMock"
                        }
                    }

                    context("Errors")
                    {
                        beforeEach { setup(for: "Errors") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("HWPOSIX")
                    {
                        beforeEach { setup(for: "HWPOSIX") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("Task")
                    {
                        beforeEach { setup(for: "Task") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("SwiftFormatWorker")
                    {
                        beforeEach { setup(for: "SwiftFormatWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Foundation,HighwayDispatch,SignPost,SourceryAutoProtocols,SwiftFormatWorker,ZFile,ZFileMock"
                        }
                    }

                    context("HWSetup")
                    {
                        beforeEach { setup(for: "HWSetup") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("CarthageWorker")
                    {
                        beforeEach { setup(for: "CarthageWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }

                    context("GitHooks")
                    {
                        beforeEach { setup(for: "GitHooks") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Arguments,Errors,Foundation,GitHooks,SignPost,SourceryAutoProtocols,Terminal,ZFile,ZFileMock"
                        }
                    }

                    context("HighwayDispatch")
                    {
                        beforeEach { setup(for: "HighwayDispatch") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Errors,Foundation,HighwayDispatch,SignPost,SourceryAutoProtocols,ZFileMock"
                        }
                    }

                    context("Stub")
                    {
                        beforeEach { setup(for: "Stub") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == ""
                        }
                    }
                }
            }
        }
    }
}
