//
//  HWCarthageSpec.swift
//  Highway
//
//  Created by Stijn Willems on 19/03/2019.
//

import Foundation

import HWCarthage
import Nimble
import Quick
import Terminal
import ZFile
import HWCarthageMock

class HWCarthageSpec: QuickSpec
{
    override func spec()
    {
        describe("HWCarthage")
        {
            var sut: HWCarthage?

            let dispatchGroup = DispatchGroup()

            let builder: CarthageBuilderProtocolMock!
            
            beforeEach
            {
                builder =  CarthageBuilderProtocolMock()
                expect
                {
                    let srcRoot = try File(path: #file).parentFolder().parentFolder()
                    sut = HWCarthage(srcRoot: srcRoot, dispatchGroup: dispatchGroup)

                    return true
                }.toNot(throwError())
            }

            it("runs")
            {
                var result: HWCarthage.SyncOutput?

                sut?.attempt { result = $0 }

                expect { try result?() }.toNot(throwError())
            }
        }
    }
}
