import Arguments
import ArgumentsMock
import Errors
import Foundation
import GitHooksMock
import Highway
import HighwayDispatchMock
import Nimble
import Quick
import SignPost
import SignPostMock
import SourceryWorkerMock
import SwiftFormatWorkerMock
import Terminal
import TerminalMock
import ZFile
import ZFileMock

private class SWM: SwiftFormatWorkerProtocolMock
{}

private class GHWM: GitHooksWorkerProtocolMock
{}

private class SourceryWorkerMock: SourceryWorkerProtocolMock
{}

private class SourceryBuilderMock: SourceryBuilderProtocolMock
{
    let executable = try! FileProtocolMock()

    required init(terminalWorker: TerminalWorkerProtocol, disk: DependencyProtocol?, signPost: SignPostProtocol, systemExecutableProvider: SystemExecutableProviderProtocol) throws
    {
        try super.init(terminalWorker: terminalWorker, disk: disk, signPost: signPost, systemExecutableProvider: systemExecutableProvider)
        attemptToBuildSourceryIfNeededClosure = {
            return self.executable
        }
    }
}

private class SourceryMock: SourceryProtocolMock
{
    required init(productName: String, swiftPackageDependencies: DependencyProtocol, swiftPackageDump: DumpProtocol, sourceryExecutable: FileProtocol, signPost: SignPostProtocol) throws
    {
        try super.init(productName: productName, swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, sourceryExecutable: sourceryExecutable, signPost: signPost)
    }
}

private class FolderMock: FolderProtocolMock
{
    let githooks = try! FolderProtocolMock()

    required init() throws
    {
        throw "mock not working"
    }

    required init(path: String) throws
    {
        try super.init(path: path)

        subfolderNamedClosure = { foldername in

            switch foldername
            {
            case ".git/hooks":
                return self.githooks
            default:
                throw "FolderMock cannot deliver subfolder \(foldername) "
            }
        }
    }

    required init?(possbilyInvalidPath: String)
    {
        fatalError("init(possbilyInvalidPath:) has not been implemented")
    }
}

class HighwaySpec: QuickSpec
{
    var sut: Highway?

    var srcRootDependencies: DependencyProtocolMock!
    var extraFolders: [FolderProtocolMock]!
    var highwaySetupProductName: String?
    var swiftformat: SwiftFormatWorkerProtocolMock!
    var githooks: GitHooksWorkerProtocolMock!
    var sourceryWorker: SourceryWorkerProtocolMock!
    var sourceryBuilder: SourceryBuilderProtocolMock!
    var terminal: TerminalWorkerProtocolMock!
    var signPost: SignPostProtocolMock!
    var queue: HighwayDispatchProtocolMock!

    override func spec()
    {
        describe("Highway")
        {
            beforeEach
            {
                expect
                {
                    self.srcRootDependencies = DependencyProtocolMock()
                    let srcRoot = try FolderProtocolMock()
                    self.srcRootDependencies.srcRootReturnValue = srcRoot

                    let extraFolder = try FolderProtocolMock()
                    self.extraFolders = [extraFolder]

                    self.highwaySetupProductName = "Mock"

                    self.terminal = TerminalWorkerProtocolMock()
                    let terminalShowDependenciesRepsonse = """
                    {
                      "name": "Highway",
                      "url": "https://www.highway.com",
                      "version": "unspecified",
                      "path": "˜/Highway",
                      "dependencies": [
                        {
                          "name": "ZFile",
                          "url": "https://www.github.com/doozMen/ZFile",
                          "version": "2.2.2",
                          "path": "˜/.build/checkouts/ZFile-1686779304139041409",
                          "dependencies": []
                        },
                            {
                          "name": "template-sourcery",
                          "url": "https://www.github.com/doozMen/template-sourcery",
                          "version": "1.0.2",
                            "path": "˜/sourceryType",
                          "dependencies": []
                        }
                      ]
                    }
                    """.components(separatedBy: "\n")

                    let terminalDumpPackageRepsonse = """
                    {
                      "name": "Highway",
                      "products": [
                        {
                          "name": "HWSetup",
                          "product_type": "executable",
                          "targets": [
                            "HWSetup"
                          ]
                        }
                      ],
                      "targets": [
                        {
                          "dependencies": [
                            {
                              "name": "SourceryAutoProtocols",
                              "type": "byname"
                            }
                          ],
                          "exclude": [
                            
                          ],
                          "name": "Errors",
                          "path": null,
                          "publicHeadersPath": null,
                          "sources": null,
                          "type": "regular"
                        }
                      ]
                    }
                    """.components(separatedBy: "\n")

                    self.terminal.runProcessClosure = { (process: Process) in

                        guard let command = process.executableURL?.absoluteString,
                            let arguments = process.arguments,
                            command.hasSuffix("swift") else
                        {
                            throw "terminal cannot respond to \(String(describing: process.executableURL))"
                        }

                        if arguments.contains("show-dependencies")
                        {
                            return terminalShowDependenciesRepsonse
                        }
                        else if arguments.contains("dump-package")
                        {
                            return terminalDumpPackageRepsonse
                        }
                        else
                        {
                            throw "terminal cannot respond to \(command) \(arguments)"
                        }
                    }

                    self.signPost = SignPostProtocolMock()
                    self.queue = HighwayDispatchProtocolMock()
                    self.queue.asyncSyncClosure = { $0() }

                    self.sut = try Highway(
                        srcRootDependencies: self.srcRootDependencies,
                        extraFolders: self.extraFolders,
                        highwaySetupProductName: self.highwaySetupProductName,
                        swiftformatType: SWM.self,
                        githooksType: GHWM.self,
                        sourceryWorkerType: SourceryWorkerMock.self,
                        sourceryBuilderType: SourceryBuilderMock.self,
                        terminal: self.terminal,
                        signPost: self.signPost,
                        queue: self.queue,
                        sourceryType: SourceryMock.self,
                        folderType: FolderMock.self
                    )
                    return self.sut
                }.toNot(throwError())
            }

            it("highway setup and mocked")
            {
                expect(self.sut).toNot(beNil())
            }
        }
    }
}
