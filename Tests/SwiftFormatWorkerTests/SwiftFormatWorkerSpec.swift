//
//  SwiftFormatWorkerTests.swift
//  SwiftFormatWorkerTests
//
//  Created by Stijn on 03/01/2019.
//

import Foundation
import Nimble
import Quick

import HighwayDispatchMock
import SignPostMock
import SwiftFormatWorker
import ZFile
import ZFileMock

class SwiftFormatWorkerSpec: QuickSpec
{
    override func spec()
    {
        super.spec()

        var sut: SwiftFormatWorker?

        var folderToFormatRecursive: FolderProtocolMock!
        var signPost: SignPostProtocolMock!

        var queue: HighwayDispatchProtocolMock!
        var swiftFormatFile: FileProtocolMock!

        context("no swiftformat yml file")
        {
            beforeEach
            {
                queue = HighwayDispatchProtocolMock()
                queue.asyncSyncClosure = { $0() }

                signPost = SignPostProtocolMock()
                swiftFormatFile = try! FileProtocolMock()

                expect
                {
                    folderToFormatRecursive = try FolderProtocolMock()
                    folderToFormatRecursive.fileNamedClosure = { _ in
                        throw ZFile.FileSystem.Item.PathError.invalid("mocked to not have the file already")
                    }
                    folderToFormatRecursive.createFileIfNeededNamedClosure = { _ in
                        swiftFormatFile
                    }

                    sut = try SwiftFormatWorker(
                        folderToFormatRecursive: folderToFormatRecursive,
                        queue: queue,
                        signPost: signPost
                    )

                    return sut
                }.toNot(throwError())
            }

            it("creates swiftformat-x-.yml file")
            {
                var testRan = false

                sut?.attempt
                { _result in
                    try? _result()
                    testRan = true
                    return
                }
                expect(folderToFormatRecursive.createFileIfNeededNamedReceivedFileName) == SwiftFormatWorker.rulesPath

                expect(testRan) == true
            }
        }
    }
}
