//
//  HWPodSpec.swift
//  Highway
//
//  Created by Stijn Willems on 19/03/2019.
//

import Foundation

import HWPod
import Nimble
import Quick
import SignPostMock
import TerminalMock
import ZFile
import ZFileMock

class HWPodSpec: QuickSpec
{
    override func spec()
    {
        describe("HWPod")
        {
            var sut: HWPod?

            var folder: FolderProtocolMock!
            var terminal: TerminalProtocolMock!
            var signPost: SignPostProtocolMock!
            var fileSystem: FileSystemProtocolMock!
            var system: SystemProtocolMock!
            var podProcess: ProcessProtocolMock!

            beforeEach
            {
                folder = try! FolderProtocolMock()
                terminal = TerminalProtocolMock()
                signPost = SignPostProtocolMock()
                fileSystem = FileSystemProtocolMock()
                system = SystemProtocolMock()

                podProcess = ProcessProtocolMock()
                system.processReturnValue = podProcess

                fileSystem.underlyingCurrentFolder = try! File(path: #file).parentFolder().parentFolder() as! Folder

                terminal.runProcessClosure = { _ in ["1.5.3"] }

                sut = HWPod(
                    podFolder: folder,
                    terminal: terminal,
                    signPost: signPost,
                    fileSystem: fileSystem,
                    system: system
                )
            }

            it("runs cocoapods")
            {
                expect { try sut?.attempt() }.toNot(throwError())
                expect(terminal.runProcessReceivedProcessTask?.arguments?.joined(separator: ",")) == "_1.5.3_,install"
            }
        }
    }
}
