import Nimble
import Quick

import ArgumentsMock
import Foundation
import GitHooksMock
import Highway
import HighwayDispatchMock
import HighwayMock
import SignPostMock
import SourceryWorker
import SourceryWorkerMock
import SwiftFormatWorkerMock
import Terminal
import TerminalMock
import ZFileMock

final class HWSetupSpec: QuickSpec
{
    override func spec()
    {
        describe("HighwayRunner")
        {
            var sut: HighwayRunner?

            var highway: HighwayProtocolMock!
            var terminal: TerminalWorkerProtocolMock!
            var signPost: SignPostProtocolMock!
            var queue: HighwayDispatchProtocolMock!

            var swiftformat: SwiftFormatWorkerProtocolMock!
            var package: PackageProtocolMock!
            var dependencies: DependencyProtocolMock!
            var srcRoot: FolderProtocolMock!
            var sourceryWorker: SourceryWorkerProtocolMock!
            var sourcery: SourceryProtocolMock!
            var githooks: GitHooksWorkerProtocolMock!

            beforeEach
            {
                githooks = GitHooksWorkerProtocolMock()
                sourceryWorker = SourceryWorkerProtocolMock()
                sourcery = SourceryProtocolMock()
                sourceryWorker.underlyingSourcery = sourcery

                terminal = TerminalWorkerProtocolMock()
                signPost = SignPostProtocolMock()
                queue = HighwayDispatchProtocolMock()
                highway = HighwayProtocolMock()
                swiftformat = SwiftFormatWorkerProtocolMock()
                highway.underlyingSwiftformat = swiftformat

                package = PackageProtocolMock()
                dependencies = DependencyProtocolMock()

                srcRoot = try! FolderProtocolMock()
                terminal.runProcessClosure = { _ in
                    ["terminal mocked success output"]
                }

                dependencies.srcRootClosure = {
                    return srcRoot
                }

                package.underlyingDependencies = dependencies

                highway.packages = [package]

                queue.asyncSyncClosure = { $0() }

                swiftformat.attemptClosure = { async in
                    async { return }
                }

                highway.sourceryWorkers = [sourceryWorker]

                sourceryWorker.attemptClosure = { async in
                    async { return ["mocked sourceryworker success output"] }
                }

                highway.underlyingGithooks = githooks
                expect
                {
                    sut = HighwayRunner(highway: highway!, dispatchGroup: DispatchGroup(), queue: queue, terminal: terminal, signPost: signPost)

                    return sut
                }.toNot(throwError())
            }

            it("runs tests")
            {
                var actual: HighwayRunner.SyncTestOutput?

                sut?.runTests { actual = $0 }

                expect(actual).toNot(beNil())
                expect { try actual?() }.toNot(throwError())
            }

            it("runs swiftFormat")
            {
                var actual: HighwayRunner.SyncSwiftformat?

                sut?.runSwiftformat { actual = $0 }

                expect(actual).toNot(beNil())
                expect { try actual?() }.toNot(throwError())
                expect(swiftformat.attemptCalled) == true
            }

            it("runs sourcery")
            {
                var actual: SourceryWorker.SyncOutput?

                sut?.runSourcery { actual = $0 }

                expect(actual).toNot(beNil())
                expect { try actual?() }.toNot(throwError())
                expect(sourceryWorker.attemptCalled) == true
            }

            it("adds git hooks script")
            {
                expect { try sut?.addGithooksPrePush() }.toNot(throwError())

                expect(githooks.addPrePushToGitHooksCalled) == true
            }
        }
    }
}
