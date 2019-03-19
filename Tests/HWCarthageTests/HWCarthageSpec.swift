//
//  HWCarthageSpec.swift
//  Highway
//
//  Created by Stijn Willems on 19/03/2019.
//

import Foundation

import Arguments
import ArgumentsMock
import HighwayDispatchMock
import HighwayMock
import HWCarthage
import HWCarthageMock
import Nimble
import Quick
import Terminal
import TerminalMock
import ZFile

class HWCarthageSpec: QuickSpec
{
    var cartfile: FileProtocol?
    var cartfileResolved: FileProtocol?

    override func spec()
    {
        describe("HWCarthage")
        {
            var sut: HWCarthage?

            let dispatchGroup = DispatchGroup()

            var builder: CarthageBuilderProtocol!
            var queue: HighwayDispatchProtocolMock!
            var highway: HighwayProtocolMock!
            var terminal: TerminalProtocolMock!

            beforeSuite
            {
                queue = HighwayDispatchProtocolMock()

                highway = HighwayProtocolMock()
                let package = PackageProtocolMock()

                highway.underlyingPackage = (package: package, executable: "Mock")

                builder = CarthageBuilder(highway: highway)

                expect
                {
                    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
                    FileManager.default.changeCurrentDirectoryPath(srcRoot.path)

                    self.cartfile = try srcRoot.createFileIfNeeded(named: "Cartfile")
                    self.cartfileResolved = try srcRoot.createFileIfNeeded(named: "Cartfile.resolved")

                    let carthageDependency = Dependency(name: "Carthage", path: "", url: URL(string: "https://www.github.com/Carthage/Carthage")!, version: "1.0.0", dependencies: [])
                    let dependency = Dependency(name: "HWSetup", path: "", url: URL(string: "https://www.github.com/dooZdev/Highway")!, version: "1.0.0", dependencies: [carthageDependency])

                    package.underlyingDependencies = dependency

                    queue.asyncSyncClosure = { $0() }

                    terminal = TerminalProtocolMock()
                    terminal.runProcessClosure = { _ in ["mock success"] }

                    sut = HWCarthage(highway: highway, dispatchGroup: dispatchGroup, carthageBuilder: builder, queue: queue, terminal: terminal)

                    return true
                }.toNot(throwError())
            }

            afterSuite
            {
                do
                {
                    try self.cartfile?.delete()
                    try self.cartfileResolved?.delete()
                }
                catch
                {
                    print("\(error)")
                }
            }

            it("runs after building carthage")
            {
                var result: HWCarthage.SyncOutput?

                sut?.attemptToBuildCarthageIfNeeded { result = $0 }

                expect { try result?() }.toNot(throwError())
                expect { try terminal.runProcessReceivedProcessTask?.executableFile().path }.to(endWith(CarthageBuilder.carthageExecutablePath))
                expect(terminal.runProcessReceivedProcessTask?.arguments?.joined(separator: ",")) == "update,--no-build"
            }
        }
    }
}
