//
//  GitHooksSpec.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

import Errors
import GitHooksLibrary
import Nimble
import Quick
import SignPostMock
import Terminal
import TerminalMock
import ZFileMock

private let expectedPrePushScript = GitHooksWorker.prepushBashScript
    .replacingOccurrences(of: "<#srcroot#>", with: "mockedRoot")
    .replacingOccurrences(of: "<#executable name#>", with: "GitHooksWorkerSpec")
    .replacingOccurrences(of: "<#options#>", with: GitHooksWorker.defaultOptions)

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
            var signPost: SignPostProtocolMock!

            beforeEach
            {
                signPost = SignPostProtocolMock()

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

                    sut = GitHooksWorker(swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, signPost: signPost)
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

            context("githooks disabled from commandline")
            {
                beforeEach
                {
                    sut = GitHooksWorker(
                        swiftPackageDependencies: swiftPackageDependencies,
                        swiftPackageDump: swiftPackageDump,
                        commandlineOptions: Set([.noGitHooksPrePush]),
                        signPost: signPost
                    )

                    expect { try sut?.addPrePushToGitHooks() }.toNot(throwError())
                }

                it("should not ask package for the githooks folder")
                {
                    expect(swiftPackageDependencies.gitHooksCalled) == false
                }

                it("warns about the disabling")
                {
                    expect(signPost.messageReceivedText) == "⚠️ 👀 GitHooksWorker ignore M (114, 90) GitHooksWorker.swift addPrePushToGitHooks() - remove noGitHooksPrePush if you do not want this"
                }
            }
        }
    }
}
