//
//  SwiftFormatWorkerTests.swift
//  SwiftFormatWorkerTests
//
//  Created by Stijn on 03/01/2019.
//

import Nimble
import Quick

import SwiftFormatWorker
import ZFile
import ZFileMock
import SignPostMock

class SwiftFormatWorkerTests: QuickSpec
{
    override func spec()
    {
        super.spec()
        
        var sut: SwiftFormatWorker?

        var folderToFormatRecursive: FolderProtocolMock!
        var bundle: BundleProtocolMock!
        var signPost: SignPostProtocolMock!
        
        var swiftFormatFile: FileProtocolMock!
        
        beforeEach {
            
            expect {
                
                folderToFormatRecursive = try FolderProtocolMock()
                bundle = BundleProtocolMock()
                signPost = SignPostProtocolMock()
                swiftFormatFile = try FileProtocolMock()
                
                bundle.fileforResourceWithOfClosure = { _, _ in return swiftFormatFile }
                
                sut = try SwiftFormatWorker(
                    folderToFormatRecursive: folderToFormatRecursive,
                    bundle: bundle,
                    queue: DispatchQueue.main,
                    signPost: signPost
                )
                
                return true
            }.toNot(throwError())
        }
        
        it("does not throw on init")
        {
            var testRan = false
            
            sut?.attempt { _result in
                try? _result()
                testRan = true
                return
            }
            
            expect(testRan).toEventually(beTrue())
        }
        
        
    }
}
