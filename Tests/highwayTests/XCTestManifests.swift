import XCTest

#if !os(macOS)
    public func allTests() -> [XCTestCaseEntry]
    {
        return [
            testCase(highwayTests.allTests),
        ]
    }
#endif
