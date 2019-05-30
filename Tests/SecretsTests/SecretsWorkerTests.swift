import Errors
import Foundation
import Nimble
import Quick
import SecretsLibrary
import SignPostMock
import TerminalMock
import ZFile
import ZFileMock

class SecretsWorkerSpec: QuickSpec
{
    override func spec()
    {
        describe("SecretsWorker")
        {
            var sut: SecretsWorker?

            var terminal: TerminalProtocolMock!
            var system: SystemProtocolMock!
            var signPost: SignPostProtocolMock!
            var fileSystem: FileSystemProtocolMock!

            beforeEach
            {
                terminal = TerminalProtocolMock()
                system = SystemProtocolMock()
                signPost = SignPostProtocolMock()
                fileSystem = FileSystemProtocolMock()

                system.installOrGetProcessFromBrewFormulaInReturnValue = ProcessProtocolMock()
                system.processReturnValue = ProcessProtocolMock()

                sut = SecretsWorker(
                    terminal: terminal,
                    system: system,
                    signPost: signPost,
                    fileSystem: fileSystem
                )
            }

            it("has test subject sut") { expect(sut).toNot(beNil()) }

            context("secrets added")
            {
                var expectedFilePaths = [String]()
                let expecteHideResponse = ["mocked hide ok"]
                let expectedGitOutput = ["git commit ok mock output"]

                let folder = try! FolderProtocolMock()

                beforeEach
                {
                    terminal.runProcessClosure = { process in

                        var error = "\(process) not defined in mock terminal"
                        guard let argument = process.arguments?.first else
                        {
                            throw error
                        }
                        error.append(" \(argument)")

                        if argument == "changes"
                        {
                            return expectedFilePaths
                        }
                        else if argument == "list"
                        {
                            return expectedFilePaths
                        }
                        else if argument == "hide"
                        {
                            return expecteHideResponse
                        }
                        else if argument == "add" || argument == "commit"
                        {
                            return expectedGitOutput
                        }
                        else
                        {
                            throw error
                        }
                    }
                }
                afterEach
                {
                    expectedFilePaths = [String]()
                }

                context("secret file changed")
                {
                    beforeEach
                    {
                        expectedFilePaths = ["path1", "path2"]
                    }

                    it("returns changed file path")
                    {
                        expect { try sut?.secretsChangedSinceLastPush(in: folder) } == expectedFilePaths
                    }

                    it("hides secrets")
                    {
                        expect { try sut?.attemptHideSecrets(in: folder) } == expecteHideResponse
                    }

                    it("throws for gpg")
                    {
                        let folder = try! FolderProtocolMock()
                        folder.makeFileSequenceReturnValue = try! File(path: #file).parentFolder().makeFileSequence()

                        expect { try sut?.attemptHideSecretsWithgpg(in: folder) }.to(throwError(SecretsWorker.Error.location("M (268, 49) SecretsWorker.swift attemptHideSecretsWithgpg(in:)", .runSecretsExecutable)))
                    }
                }

                context("NO secrets changed")
                {
                    beforeEach
                    {
                        expectedFilePaths = []
                    }

                    it("returns changed file path")
                    {
                        let folder = try! FolderProtocolMock()

                        expect { try sut?.secretsChangedSinceLastPush(in: folder) } == []
                    }

                    it("NO secrets to hide")
                    {
                        expect { try sut?.attemptHideSecrets(in: folder) } == ["M (144, 39) SecretsWorker.swift attemptHideSecrets(in:) no secret changes, skipping"]
                    }

                    it("throws for gpg")
                    {
                        let folder = try! FolderProtocolMock()
                        folder.makeFileSequenceReturnValue = try! File(path: #file).parentFolder().makeFileSequence()

                        expect { try sut?.attemptHideSecretsWithgpg(in: folder) } == ["M (218, 39) SecretsWorker.swift attemptHideSecretsWithgpg(in:) no secrets changed, skipping!"]
                    }
                }
            }
        }
    }
}
