import XCTest
@testable import highway

final class highwayTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(highway().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}