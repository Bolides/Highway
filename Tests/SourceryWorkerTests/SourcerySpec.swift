//
//  SourcerySpec.swift
//  TerminalTests
//
//  Created by Stijn Willems on 11/03/2019.
//

import Foundation

import Errors
import Nimble
import Quick
import SourceryWorker
import SourceryWorkerMock
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

            var templateFolder: FolderProtocolMock!
            var autoProtocolsFile: FileProtocolMock!

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

                    templateFolder = try FolderProtocolMock()
                    autoProtocolsFile = try FileProtocolMock()

                    sourceryBuilder.templateFolderReturnValue = templateFolder
                    sourceryBuilder.sourceryAutoProtocolFileReturnValue = autoProtocolsFile

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

                    context("SourceryWorker")
                    {
                        beforeEach { setup(for: "SourceryWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Errors,Foundation,HighwayDispatch,Result,SignPost,SourceryWorker,Terminal,ZFile"
                        }
                    }

                    context("Terminal")
                    {
                        beforeEach { setup(for: "Terminal") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Errors,Foundation,HighwayDispatch,Result,SignPost,Terminal,ZFile,ZFileMock"
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

                    context("SwiftFormatWorker")
                    {
                        beforeEach { setup(for: "SwiftFormatWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Errors,Foundation,HighwayDispatch,Result,SignPost,SwiftFormat,SwiftFormatWorker,Terminal,ZFile"
                        }
                    }

                    context("HighwayLibrary")
                    {
                        beforeEach { setup(for: "HighwayLibrary") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "DocumentationLibrary,Errors,Foundation,GitHooksLibrary,HighwayDispatch,HighwayLibrary,SecretsLibrary,SignPost,SourceryAutoProtocols,SourceryWorker,SwiftFormatWorker,Terminal,ZFile"
                        }
                    }

                    context("CarthageWorker")
                    {
                        beforeEach { setup(for: "CarthageWorker") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "CarthageWorker,Errors,Foundation,HighwayDispatch,Result,SignPost,Terminal,ZFile"
                        }
                    }

                    context("GitHooksLibrary")
                    {
                        beforeEach { setup(for: "GitHooksLibrary") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Errors,Foundation,GitHooksLibrary,HighwayDispatch,Result,SignPost,Terminal,ZFile"
                        }
                    }

                    context("HighwayDispatch")
                    {
                        beforeEach { setup(for: "HighwayDispatch") }

                        it("has imports for automockable")
                        {
                            expect(sut?.imports.first { $0.template == "AutoMockable" }?.names.map { $0.name }.sorted().joined(separator: ",")) == "Foundation,HighwayDispatch,SourceryAutoProtocols"
                        }
                    }
                }
            }
        }
    }
}
