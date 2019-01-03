//
//  SwiftformatWorkerTests.swift
//  SwiftformatWorkerTests
//
//  Created by Stijn on 03/01/2019.
//

import Nimble
import Quick

import SwiftFormatWorker
import ZFile
import ZFileMock

class SwiftformatWorkerTests: QuickSpec
{
    override func spec()
    {
        super.spec()

        it("does not throw on init")
        {
            expect { try SwiftFormatWorker() }.toNot(throwError())
        }
    }
}
