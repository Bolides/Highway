import Foundation
import SourceryAutoProtocols
import SignPost

public protocol TestReportProtocol: AutoMockable {
    /// sourcery:inline:TestReport.AutoGenerateProtocol
    var failingTests: ArraySlice<String>? { get }
    var description: String { get }

    func failedTests() -> String
    /// sourcery:end
}

public struct TestReport: TestReportProtocol, AutoGenerateProtocol, CustomStringConvertible
{
    public let failingTests: ArraySlice<String>?
    
    private let output: [String]
    private let signPost: SignPostProtocol
    
    public init(output: [String], signPost: SignPostProtocol = SignPost.shared) {
        
        self.output = output
        self.signPost = signPost
        
        guard let indexFailing = output.firstIndex(of: "Failing tests:"),
            let failingEnd = output.firstIndex(of: "** TEST FAILED **") else {
                failingTests = nil
                return
        }
        
        failingTests = output[indexFailing..<failingEnd]
    }
    
    public func failedTests() -> String {
        return output.filter { $0.hasPrefix("failed") }.joined()
    }
    
    public var description: String {
        
        guard
            let failingTests = self.failingTests?.dropFirst(),
            let title = self.failingTests?.first
        else {
            signPost.verbose(output.joined(separator: "\n"))
            return "No failed tests"
        }
        
        return """
        TestReport
        
        ⚠️ \(failingTests.count) \(title)
        
        \(failingTests.map { "    * \($0)"}.joined(separator: "\n"))
        
        🚀 go fix them and them and after ... 🍻
        
        """
    }
    
}
