//
//  SwiftformatWorkerTests.swift
//  SwiftformatWorkerTests
//
//  Created by Stijn on 03/01/2019.
//

import Quick
import Nimble

import SwiftformatWorker

class SwiftformatWorkerTests: QuickSpec {

    override func spec() {
        super.spec()
        
        var sut: SwiftformatWorker!
        
        beforeEach {
            sut = SwiftformatWorker()
        }
    }
    
}
