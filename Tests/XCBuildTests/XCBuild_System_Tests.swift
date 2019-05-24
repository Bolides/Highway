import Nimble
import Quick

import Arguments
import ArgumentsMock
import Terminal
import TerminalMock
import XCBuild
import XCBuildMock
import ZFileMock

class XCBuildSpec: QuickSpec
{
    override func spec()
    {
        describe("XCBuild")
        {
            var sut: XCBuild?

            var terminal: TerminalProtocolMock!
            var xcbuildExecutable: MinimalTestOptionsProtocolMock!
            var system: SystemProtocolMock!

            beforeEach
            {
                xcbuildExecutable = MinimalTestOptionsProtocolMock()
                terminal = TerminalProtocolMock()
                system = SystemProtocolMock()

                sut = XCBuild(systemExecutableProvider: system, terminalWorker: terminal)
            }

            context("build and test")
            {
                beforeEach
                {
                    xcbuildExecutable.argumentsReturnValue = Arguments([""])
                    system.executableWithReturnValue = try? FileProtocolMock()

                    terminal.runProcessClosure = { _ in
                        [
                            "Test Suite 'XCBuildSpec' failed at 2019-05-24 18:32:54.809.",
                            "   Executed 2 tests, with 0 failure (0 unexpected) in 0.002 (0.002) seconds",
                        ]
                    }
                    expect { try sut?.buildAndTest(using: xcbuildExecutable) }.toNot(throwError())
                }

                it("call terminal")
                {
                    expect(terminal.runProcessCalled) == true
                }
            }

            context("get possible destinations")
            {
                let expected = "{mocked destination}"

                beforeEach
                {
                    xcbuildExecutable.argumentsReturnValue = Arguments([""])
                    system.executableWithReturnValue = try? FileProtocolMock()

                    terminal.runProcessClosure = { _ in
                        [expected]
                    }
                }

                it("returns detinations")
                {
                    expect { try sut?.findPosibleDestinations(for: "bla", in: try FolderProtocolMock()) } == [expected]
                }
            }
        }
    }
}
