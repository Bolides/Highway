//
//  GitHooksSpec.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

import Arguments
import ArgumentsMock
import Errors
import GitHooks
import Nimble
import Quick
import ZFileMock

private let expectedPrePushScript = GitHooksWorker.prepushBashScript
    .replacingOccurrences(of: "<#srcroot#>", with: "mockedRoot")
    .replacingOccurrences(of: "<#executable name#>", with: "GitHooksWorkerSpec")

class GitHooksWorkerSpec: QuickSpec
{
    override func spec()
    {
        describe("GitHooksWorker")
        {
            var sut: GitHooksWorker?

            var gitHooksFolder: FolderProtocolMock!
            var prePushFile: FileProtocolMock!
            var swiftPackageDependencies: DependencyProtocolMock!
            var swiftPackageDump: DumpProtocolMock!

            beforeEach
            {
                gitHooksFolder = try! FolderProtocolMock()
                prePushFile = try! FileProtocolMock()

                swiftPackageDependencies = DependencyProtocolMock()
                swiftPackageDependencies.gitHooksClosure = { return gitHooksFolder }

                swiftPackageDump = DumpProtocolMock()
                let executable = SwiftProduct(name: "GitHooksWorkerSpec", product_type: "executable")
                swiftPackageDump.products = Set([executable])

                let scrRoot = try! FolderProtocolMock()
                scrRoot.underlyingPath = "mockedRoot"
                swiftPackageDependencies.srcRootReturnValue = scrRoot
            }

            context("pre-push is still sample")
            {
                beforeEach
                {
                    prePushFile = try! FileProtocolMock()
                    gitHooksFolder.fileNamedClosure = { filename in

                        if filename == "pre-push.sample"
                        {
                            return prePushFile
                        }
                        else if filename == "pre-push"
                        {
                            throw "handling case of sample"
                        }

                        throw "mock gitHooksFolder has no file for name \(filename)"
                    }

                    sut = GitHooksWorker(swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump)
                    expect { try sut?.addPrePushToGitHooks() }.toNot(throwError())
                }

                it("renames")
                {
                    expect(prePushFile.renameToKeepExtensionReceivedArguments?.newName) == "pre-push"
                    expect(prePushFile.renameToKeepExtensionReceivedArguments?.keepExtension) == false
                }

                it("writes script")
                {
                    expect(prePushFile.writeStringReceivedString) == expectedPrePushScript
                }
            }

            context("pre-push is not a sample")
            {
                beforeEach
                {
                    prePushFile = try! FileProtocolMock()
                    gitHooksFolder.fileNamedClosure = { filename in

                        if filename == "pre-push.sample"
                        {
                            throw "handling case of sample"
                        }
                        else if filename == "pre-push"
                        {
                            return prePushFile
                        }

                        throw "mock gitHooksFolder has no file for name \(filename)"
                    }

                    sut = GitHooksWorker(swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump)
                    expect { try sut?.addPrePushToGitHooks() }.toNot(throwError())
                }

                it("renames")
                {
                    expect(prePushFile.renameToCalled) == false
                }

                it("writes script")
                {
                    expect(prePushFile.writeStringReceivedString) == expectedPrePushScript
                }
            }
        }
    }
}
