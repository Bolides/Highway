import Foundation
import Nimble
import Quick
import SignPostMock
import Terminal
import TerminalMock
import ZFile
import ZFileMock

class SwiftPackageDependencyServiceSpec: QuickSpec
{
    override func spec()
    {
        describe("SwiftPackageDependencyService - real swift package output")
        {
            var expectedSwiftPackage: DependencyProtocol?

            beforeSuite
            {
                // get real dependencies
                expect
                {
                    let srcroot = try File(path: #file).parentFolder().parentFolder().parentFolder()
                    FileManager.default.changeCurrentDirectoryPath(srcroot.path)
                    expectedSwiftPackage = try DependencyService(in: srcroot).generateDependency()

                    return true
                }.toNot(throwError())
            }

            it("have dependencies of Highway package")
            {
                expect(expectedSwiftPackage?.dependencies.map { $0.name }.sorted().joined(separator: ",")) == "Nimble,Quick,Result,SignPost,Sourcery,SwiftFormat,ZFile,template-sourcery"
            }

            context("its dependencies have dependencies")
            {
                it("ZFile")
                {
                    let zfile = expectedSwiftPackage?.dependencies.first { $0.name == "ZFile" }
                    expect(zfile?.dependencies.map { $0.name }.sorted().joined(separator: ", ")) == "Nimble, Quick"
                }
            }
        }

        describe("SwiftPackageDependencyService - mocked swift package output")
        {
            var sut: DependencyService?

            var expectedSwiftPackage: DependencyProtocol?
            var srcroot: FolderProtocol!

            var system: SystemProtocolMock!
            var terminal: TerminalProtocolMock!
            var signPost: SignPostProtocolMock!

            var showDependencyProcess: ProcessProtocolMock!

            beforeEach
            {
                srcroot = try! FolderProtocolMock()

                system = SystemProtocolMock()
                terminal = TerminalProtocolMock()
                signPost = SignPostProtocolMock()
                showDependencyProcess = ProcessProtocolMock()

                system.processReturnValue = showDependencyProcess

                sut = DependencyService(in: srcroot, system: system, terminal: terminal, signPost: signPost)
            }

            context("json output")
            {
                context("CLEAN")
                {
                    beforeEach
                    {
                        terminal.runProcessReturnValue = cleanShowDependenciesJSON

                        expect { expectedSwiftPackage = try sut?.generateDependency() }.toNot(throwError())
                    }

                    it("have dependencies of Highway package")
                    {
                        expect(expectedSwiftPackage?.dependencies.map { $0.name }.sorted().joined(separator: ",")) == "Quick"
                    }

                    context("its dependencies have dependencies")
                    {
                        it("ZFile")
                        {
                            let zfile = expectedSwiftPackage?.dependencies.first { $0.name == "Quick" }
                            expect(zfile?.dependencies.map { $0.name }.sorted().joined(separator: ", ")) == "Nimble"
                        }
                    }
                }

                context("DIRTY")
                {
                    beforeEach
                    {
                        terminal.runProcessReturnValue = dirtyShowDependenciesJSON

                        expect { expectedSwiftPackage = try sut?.generateDependency() }.toNot(throwError())
                    }

                    it("have dependencies of Highway package")
                    {
                        expect(expectedSwiftPackage?.dependencies.map { $0.name }.sorted().joined(separator: ",")) == "Quick"
                    }

                    context("its dependencies have dependencies")
                    {
                        it("ZFile")
                        {
                            let zfile = expectedSwiftPackage?.dependencies.first { $0.name == "Quick" }
                            expect(zfile?.dependencies.map { $0.name }.sorted().joined(separator: ", ")) == "Nimble"
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Test Swift package json

private let cleanShowDependenciesJSON = """
{
"name": "ZFile",
"url": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile",
"version": "unspecified",
"path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile",
"dependencies": [
        {
            "name": "Quick",
            "url": "https://github.com/Quick/Quick",
            "version": "2.0.0",
            "path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile/.build/checkouts/Quick--3538636636567862803",
            "dependencies": [
                {
                "name": "Nimble",
                "url": "https://github.com/Quick/Nimble",
                "version": "8.0.1",
                "path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile/.build/checkouts/Nimble--4657504332949577033",
                "dependencies": []
                }
            ]
        }
    ]
}
""".components(separatedBy: "\n")

private let dirtyShowDependenciesJSON = """
Updating https://github.com/Quick/Nimble
Updating https://github.com/Quick/Quick
Completed resolution in 0.98s
Cloning https://github.com/Quick/Nimble
Resolving https://github.com/Quick/Nimble at 8.0.1
Cloning https://github.com/Quick/Quick
Resolving https://github.com/Quick/Quick at 2.0.0
{
"name": "ZFile",
"url": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile",
"version": "unspecified",
"path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile",
"dependencies": [
        {
            "name": "Quick",
            "url": "https://github.com/Quick/Quick",
            "version": "2.0.0",
            "path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile/.build/checkouts/Quick--3538636636567862803",
            "dependencies": [
                {
                "name": "Nimble",
                "url": "https://github.com/Quick/Nimble",
                "version": "8.0.1",
                "path": "/Users/JohnDo/Documents/dev.nosync/Open/ZFile/.build/checkouts/Nimble--4657504332949577033",
                "dependencies": []
                }
            ]
        }
    ]
}
""".components(separatedBy: "\n")
