import Foundation
import SignPost
import SourceryAutoProtocols

public protocol TestReportProtocol: AutoMockable
{
    /// sourcery:inline:TestReport.AutoGenerateProtocol
    var failingTests: ArraySlice<String>? { get }
    var description: String { get }

    func failedTests() -> String
    /// sourcery:end
}

public struct TestReport: TestReportProtocol, AutoGenerateProtocol, CustomStringConvertible
{
    public let failingTests: ArraySlice<String>?
    public let buildErrors: [String]?
    public let output: [String]

    private let signPost: SignPostProtocol

    public init(output: [String], signPost: SignPostProtocol = SignPost.shared)
    {
        self.output = output
        self.signPost = signPost

        signPost.verbose("making testreport from raw output \n\(output.joined(separator: "\n"))\n")

        signPost.verbose("\(TestReport.self) generating test report ... ")
        signPost.verbose("\(TestReport.self) checking failed tests ")

        if let indexFailing = output.firstIndex(of: "Failing tests:"),
            let failingEnd = output.firstIndex(of: "** TEST FAILED **")
        {
            failingTests = output[indexFailing ..< failingEnd]
        }
        else
        {
            failingTests = nil
        }

        signPost.verbose("\(TestReport.self) checking build errors ")

        if (output.first { $0.contains("error:") }) != nil
        {
            buildErrors = output.filter { $0.contains("error:") }
        }
        else
        {
            buildErrors = nil
        }
    }

    public func failedTests() -> String
    {
        return output.filter { $0.hasPrefix("failed") }.joined()
    }

    public var description: String
    {
        guard
            let failingTests = self.failingTests?.dropFirst(),
            let title = self.failingTests?.first
        else
        {
            guard let buildErrors = buildErrors else
            {
                return "🧪 \(TestReport.self) ✅"
            }
            
            return """
            \(TestReport.self) build failed with errors \(buildErrors.count)
            
            \(buildErrors.enumerated().map { "    \($0.offset + 1) - \($0.element) " }.joined(separator: "\n"))
            
            """
        }

        return """
        TestReport
        
        ⚠️ \(failingTests.count) \(title)
        
        \(failingTests.map { "    * \($0)" }.joined(separator: "\n"))
        
        🚀 go fix them and them and after ... 🍻
        
        """
    }
}
