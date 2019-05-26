import DocumentationLibraryMock
import Errors
import Foundation
import Highway
import HighwayDispatchMock
import HighwayLibraryMock
import Nimble
import Quick
import SecretsLibraryMock
import SignPost
import SignPostMock
import SourceryWorker
import SourceryWorkerMock
import SwiftFormatWorkerMock
import Terminal
import TerminalMock
import XCBuild
import XCTest
import ZFile
import ZFileMock

class HighwayRunnerSpec: QuickSpec
{
    override func spec()
    {
        var sut: HighwayRunner?

        var highway: HighwayProtocolMock!

        var package: PackageProtocolMock!
        var dispatchGroup: HWDispatchGroupProtocolMock!
        var terminal: TerminalProtocolMock!

        describe("HighwayRunner")
        {
            beforeEach
            {
                expect
                {
                    dispatchGroup = HWDispatchGroupProtocolMock()

                    package = PackageProtocolMock()
                    let dependencies = DependencyProtocolMock()
                    dependencies.srcRootReturnValue = try! FolderProtocolMock()

                    package.dependencies = dependencies

                    highway = HighwayProtocolMock()
                    highway.underlyingPackage = package

                    let queue = HighwayDispatchProtocolMock()
                    queue.asyncSyncClosure = { $0() }
                    let signpost = SignPostProtocolMock()
                    signpost.messageClosure = { _ in }

                    terminal = TerminalProtocolMock()
                    let system = SystemProtocolMock()
                    system.processReturnValue = ProcessProtocolMock()

                    sut = HighwayRunner(
                        highway: highway,
                        dispatchGroup: dispatchGroup,
                        queue: queue,
                        terminal: terminal,
                        signPost: signpost,
                        system: system,
                        secretsWorker: SecretsWorkerProtocolMock(),
                        documentationWorker: DocumentationWorkerProtocolMock()
                    )
                    return sut
                }.toNot(throwError())
            }

            it("highwayRunner setup and mocked")
            {
                expect(sut).toNot(beNil())
            }

            context("No throw on success")
            {
                let successOutput = [
                    "Test Case '-[HighwayTests.HighwayRunnerSpec HighwayRunner, Reports failed tests, runs]' started.",
                    "Test Case '-[HighwayTests.HighwayRunnerSpec HighwayRunner, Reports failed tests, runs]' passed (0.001 seconds).",
                    "Test Suite 'HighwayRunnerSpec' failed at 2019-05-24 17:07:55.599.",
                    "     Executed 3 tests, with 0 failure (0 unexpected) in 0.002 (0.002) seconds",
                    "Test Suite 'HighwaySpec' started at 2019-05-24 17:07:55.599",
                    "Test Case '-[HighwayTests.HighwaySpec Conditional compilation from xcconfigOverride, should run macOS flag test]' started.",
                    "/Users/stijnwillems/Documents/dev.nosync/Open/Highway/Tests/HighwayTests/HighwayTests.swift:79: error: -[HighwayTests.HighwaySpec Conditional compilation from xcconfigOverride, should run macOS flag test] : failed - Should have MacOS flag when running test from command line and in xcode",
                    "Test Suite 'XCBuildSpec' passed at 2019-05-24 17:07:55.624.",
                    "     Executed 2 tests, with 0 failures (0 unexpected) in 0.001 (0.001) seconds",
                    "Test Suite 'HighwayPackageTests.xctest' failed at 2019-05-24 17:07:55.625.",
                    "     Executed 46 tests, with 0 failures (0 unexpected) in 7.275 (7.278) seconds",
                    "Test Suite 'All tests' failed at 2019-05-24 17:07:55.625.,",
                    "     Executed 46 tests, with 0 failures (0 unexpected) in 7.275 (7.279) seconds",
                ]

                var testReport: TestReportProtocol?

                beforeEach
                {
                    // fake failed test but succeeded build output
                    terminal.runProcessReturnValue = successOutput
                    sut?.runTests
                    { syncTestOutput in
                        do
                        {
                            testReport = try syncTestOutput()
                        }
                        catch
                        {
                            XCTFail("\(error)")
                        }
                    }
                }

                afterEach
                {
                    testReport = nil
                }

                it("no throws")
                {
                    var output = testReport?.testSuiteOutput

                    expect(output?[0]) == successOutput[2]
                    expect(output?[1]) == successOutput[3]
                    expect(output?[2]) == successOutput[4]
                }

                it("calculates number of tests")
                {
                    expect(testReport?.totalNumberOfTests) == 97
                }
            }

            context("Reports failed tests")
            {
                let failedOutput = [
                    "Test Case '-[HighwayTests.HighwayRunnerSpec HighwayRunner, Reports failed tests, runs]' started.",
                    "Test Case '-[HighwayTests.HighwayRunnerSpec HighwayRunner, Reports failed tests, runs]' passed (0.001 seconds).",
                    "Test Suite 'HighwayRunnerSpec' failed at 2019-05-24 17:07:55.599.",
                    "     Executed 3 tests, with 1 failure (0 unexpected) in 0.002 (0.002) seconds",
                    "Test Suite 'HighwaySpec' started at 2019-05-24 17:07:55.599",
                    "Test Case '-[HighwayTests.HighwaySpec Conditional compilation from xcconfigOverride, should run macOS flag test]' started.",
                    "/Users/stijnwillems/Documents/dev.nosync/Open/Highway/Tests/HighwayTests/HighwayTests.swift:79: error: -[HighwayTests.HighwaySpec Conditional compilation from xcconfigOverride, should run macOS flag test] : failed - Should have MacOS flag when running test from command line and in xcode",
                    "Test Suite 'XCBuildSpec' passed at 2019-05-24 17:07:55.624.",
                    "     Executed 2 tests, with 0 failures (0 unexpected) in 0.001 (0.001) seconds",
                    "Test Suite 'HighwayPackageTests.xctest' failed at 2019-05-24 17:07:55.625.",
                    "     Executed 46 tests, with 2 failures (0 unexpected) in 7.275 (7.278) seconds",
                    "Test Suite 'All tests' failed at 2019-05-24 17:07:55.625.,",
                    "     Executed 46 tests, with 2 failures (0 unexpected) in 7.275 (7.279) seconds",
                ]

                beforeEach
                {
                    // fake failed test but succeeded build output
                    terminal.runProcessReturnValue = failedOutput
                }

                it("runs and throws")
                {
                    var _error: TestReport.Error?

                    sut?.runTests
                    { syncTestOutput in
                        do
                        {
                            _ = try syncTestOutput()
                        }
                        catch let error as TestReport.Error
                        {
                            _error = error.indirectError
                        }
                        catch
                        {
                            XCTFail("\(error)")
                        }
                    }
                    let report = _error?.testFailedSummary

                    expect(report?[0]) == failedOutput[2]
                    expect(report?[1]) == failedOutput[3]
                    expect(report?[2]) == failedOutput[4]
                }
            }
        }
    }
}
