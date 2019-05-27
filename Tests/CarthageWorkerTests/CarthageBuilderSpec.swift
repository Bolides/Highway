//
//  CarthageBuilderSpec.swift
//  HWCarthageTests
//
//  Created by Stijn Willems on 21/03/2019.
//

import Foundation

import CarthageWorker
import Errors
import HighwayLibraryMock
import Nimble
import Quick
import SignPostMock
import Terminal
import TerminalMock
import ZFile
import ZFileMock

class CarthageBuilderSpec: QuickSpec
{
    override func spec()
    {
        describe("CarthageBuilder")
        {
            var sut: CarthageBuilder?

            var carthagePackage: PackageProtocolMock!
            var terminal: TerminalProtocolMock!
            var signPost: SignPostProtocolMock!
            var system: SystemProtocolMock!

            var carthageswiftBuildProcess: ProcessProtocolMock!
            var srcRoot: FolderProtocolMock!
            var carthageSwiftPackage: FolderProtocolMock!

            beforeEach
            {
                carthagePackage = PackageProtocolMock()
                terminal = TerminalProtocolMock()
                signPost = SignPostProtocolMock()
                system = SystemProtocolMock()

                let carthageExecutable = try! FileProtocolMock()
                carthageExecutable.underlyingPath = CarthageBuilder.carthageExecutableFolderPath + "/carthage"

                let dump = DumpProtocolMock()
                dump.underlyingProducts = Set([SwiftProduct(name: "carthage", product_type: "executable")])

                carthagePackage.underlyingDump = dump
                let dependency = DependencyProtocolMock()

                srcRoot = try! FolderProtocolMock()
                carthageSwiftPackage = try! FolderProtocolMock()

                dependency.srcRootReturnValue = srcRoot

                carthagePackage.underlyingDependencies = dependency

                sut = CarthageBuilder(
                    carthagePackage: carthagePackage,
                    terminal: terminal,
                    signPost: signPost,
                    system: system
                )

                carthageswiftBuildProcess = ProcessProtocolMock()

                system.processReturnValue = carthageswiftBuildProcess
                terminal.runProcessClosure = { _ in ["mocked build succes"] }
            }

            context("carthage not build")
            {
                beforeEach
                {
                    srcRoot.subfolderNamedClosure = { subfolder in

                        guard subfolder == CarthageBuilder.carthageExecutableFolderPath else
                        {
                            throw "subfolderNamedClosure not implemented for \(subfolder)"
                        }

                        guard srcRoot.subfolderNamedCallsCount <= 1 else
                        {
                            let carthage = try FileProtocolMock()
                            carthage.name = "carthage"

                            carthageSwiftPackage.fileNamedThrowableError = nil
                            carthageSwiftPackage.fileNamedReturnValue = carthage
                            return carthageSwiftPackage
                        }

                        carthageSwiftPackage.fileNamedThrowableError = FileSystem.Item.PathError.invalid("carthage not build mocked")
                        return carthageSwiftPackage
                    }
                }

                it("builds carthage if not build yet")
                {
                    expect { try sut?.attemptBuildCarthageIfNeeded().name } == "carthage"
                    expect(carthageswiftBuildProcess.arguments?.joined(separator: ", ")) == "build, --product, carthage, -c, release, --static-swift-stdlib"
                }
            }

            context("carthage build")
            {
                beforeEach
                {
                    srcRoot.subfolderNamedClosure = { subfolder in

                        guard subfolder == CarthageBuilder.carthageExecutableFolderPath else
                        {
                            throw "subfolderNamedClosure not implemented for \(subfolder)"
                        }

                        let carthage = try FileProtocolMock()
                        carthage.name = "carthage"

                        carthageSwiftPackage.fileNamedThrowableError = nil
                        carthageSwiftPackage.fileNamedReturnValue = carthage
                        return carthageSwiftPackage
                    }
                }

                it("builds carthage if not build yet")
                {
                    expect { try sut?.attemptBuildCarthageIfNeeded().name } == "carthage"
                    expect(carthageswiftBuildProcess.arguments).to(beNil())
                }
            }
        }
    }
}
