//
//  HWCarthageSpec.swift
//  Highway
//
//  Created by Stijn Willems on 19/03/2019.
//

import Foundation

import CarthageWorker
import CarthageWorkerMock
import HighwayDispatchMock
import HighwayLibraryMock
import Nimble
import Quick
import SignPostMock
import Terminal
import TerminalMock
import ZFileMock

class HWCarthageSpec: QuickSpec
{
    override func spec()
    {
        describe("HWCarthage")
        {
            var sut: HWCarthage?

            let dispatchGroup = DispatchGroup()

            var builder: CarthageBuilderProtocolMock!
            var queue: HighwayDispatchProtocolMock!
            var highway: HighwayProtocolMock!
            var terminal: TerminalProtocolMock!
            var signPost: SignPostProtocolMock!
            var carthageExecutable: FileProtocolMock!

            beforeSuite
            {
                signPost = SignPostProtocolMock()
                signPost.messageClosure = { _ in } // do not log
                signPost.verboseClosure = { _ in } // do not log
                signPost.errorClosure = { _ in } // do not log

                queue = HighwayDispatchProtocolMock()

                highway = HighwayProtocolMock()
                let package = PackageProtocolMock()

                highway.underlyingPackage = package

                carthageExecutable = try! FileProtocolMock()
                carthageExecutable.underlyingPath = CarthageBuilder.carthageExecutableFolderPath + "/carthage"

                builder = CarthageBuilderProtocolMock()
                builder.attemptBuildCarthageIfNeededReturnValue = carthageExecutable

                expect
                {
                    let carthageDependency = Dependency(name: "Carthage", path: "", url: URL(string: "https://www.github.com/Carthage/Carthage")!, version: "1.0.0", dependencies: [])
                    let dependency = Dependency(name: "HWSetup", path: "", url: URL(string: "https://www.github.com/dooZdev/Highway")!, version: "1.0.0", dependencies: [carthageDependency])

                    package.underlyingDependencies = dependency

                    queue.asyncSyncClosure = { $0() }

                    terminal = TerminalProtocolMock()
                    terminal.runProcessClosure = { _ in ["mock success"] }

                    sut = HWCarthage(
                        dispatchGroup: dispatchGroup,
                        carthageBuilder: builder,
                        options: Set([.carhageUpdateNoBuild]),
                        queue: queue,
                        signPost: signPost,
                        terminal: terminal
                    )

                    return true
                }.toNot(throwError())
            }

            it("runs after building carthage")
            {
                var result: HWCarthage.SyncOutput?
                let folder = try! FolderProtocolMock()

                sut?.attemptRunCarthageIfCommandLineOptionAdded(in: folder) { result = $0 }

                expect { try result?() }.toNot(throwError())
                expect { terminal.runProcessReceivedProcessTask }.toNot(beNil())
                expect(terminal.runProcessReceivedProcessTask?.arguments?.joined(separator: ",")) == "update,--no-build"
            }
        }
    }
}