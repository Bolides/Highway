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

            beforeEach
            {
                folder = try! FolderProtocolMock()
                terminal = TerminalProtocolMock()
                signPost = SignPostProtocolMock()

                terminal.runProcessClosure = {_ in return ["1.5.3"] }
                
                sut = HWPod(podFolder: folder, terminal: terminal, signPost: signPost)
            }

            it("runs cocoapods")
            {
                expect { try sut?.attempt() }.toNot(throwError())
            }
        }
    }
}
