import XCTest

import highwayTests

var tests = [XCTestCaseEntry]()
tests += highwayTests.allTests()
XCTMain(tests)