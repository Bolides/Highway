import Arguments
import ArgumentsMock
import Errors
import Foundation
import GitHooksMock
import Highway
import HighwayDispatchMock
import HighwayMock
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

    override init()
    {
        super.init()
        attemptToBuildSourceryIfNeededClosure = {
            self.executable
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

class HighwaySpec: QuickSpec
{
    var sut: Highway?

    var rootPackage: PackageProtocolMock!
    var extraFolders: [FolderProtocolMock]!
    var highwaySetupPackage: (package: PackageProtocol, executable: String)?
    var highwaySetupPackageMock: PackageProtocolMock!
    var swiftformat: SwiftFormatWorkerProtocolMock!
    var githooks: GitHooksWorkerProtocolMock!
    var sourceryWorker: SourceryWorkerProtocolMock!
    var sourceryBuilder: SourceryBuilderProtocolMock!
    var terminal: TerminalProtocolMock!
    var signPost: SignPostProtocolMock!
    var queue: HighwayDispatchProtocolMock!
    var dependencyService: DependencyServiceProtocolMock!

    override func spec()
    {
        describe("Highway")
        {
            beforeEach
            {
                expect
                {
                    let srcRoot = try FolderProtocolMock()
                    srcRoot.subfolderNamedClosure = { _ in
                        try! FolderProtocolMock()
                    }
                    let dependencies = DependencyProtocolMock()
                    dependencies.srcRootReturnValue = srcRoot

                    let dump = DumpProtocolMock()
                    dump.underlyingProducts = Set([SwiftProduct(name: "MockProduct", product_type: "library")])

                    self.rootPackage = PackageProtocolMock()
                    self.rootPackage.underlyingDependencies = dependencies
                    self.rootPackage.underlyingDump = dump

                    self.highwaySetupPackageMock = PackageProtocolMock()
                    self.highwaySetupPackageMock.underlyingDependencies = dependencies
                    self.highwaySetupPackageMock.underlyingDump = dump

                    self.highwaySetupPackage = (package: self.highwaySetupPackageMock, executable: "Mock")

                    let extraFolder = try FolderProtocolMock()
                    self.extraFolders = [extraFolder]

                    self.terminal = TerminalProtocolMock()
                    let terminalShowDependenciesRepsonse = """
                    {
                      "name": "Highway",
                      "url": "https://www.highway.com",
                      "version": "unspecified",
                        "path": "\(try File(path: #file).parentFolder().parentFolder().parentFolder().path)",
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

                    self.terminal.runProcessClosure = { process in

                        let command = try process.executableFile().path
                        guard
                            let arguments = process.arguments,
                            command.hasSuffix("swift") else
                        {
                            throw "terminal cannot respond to \(command)"
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

                    self.dependencyService = DependencyServiceProtocolMock()
                    self.dependencyService.generateDependencyReturnValue = dependencies

                    let swiftPackageWithSourceryFolder = try FolderProtocolMock()

                    self.sut = try Highway(
                        package: (package: self.rootPackage, executable: "MockedSetup"),
                        extraFolders: self.extraFolders,
                        dependencyService: self.dependencyService,
                        swiftformatType: SWM.self,
                        githooksType: GHWM.self,
                        sourceryWorkerType: SourceryWorkerMock.self,
                        sourceryBuilder: SourceryBuilderMock(),
                        terminal: self.terminal,
                        signPost: self.signPost,
                        queue: self.queue,
                        sourceryType: SourceryMock.self
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
