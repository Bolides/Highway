import Nimble
import Quick

import Task
import TaskMock
import XCBuild
import TerminalMock
import Arguments
import ArgumentsMock
import XCBuildMock
import ZFileMock

class XCBuildSpec: QuickSpec {
    
    override func spec() {
        
        describe("XCBuild") {
            
            var sut: XCBuild?
            
        
            var terminal: TerminalWorkerProtocolMock!
            var xcbuildExecutable: MinimalTestOptionsProtocolMock!
            var system: SystemExecutableProviderProtocolMock!
            
            beforeEach {
                xcbuildExecutable = MinimalTestOptionsProtocolMock()
                terminal = TerminalWorkerProtocolMock()
                system = SystemExecutableProviderProtocolMock()
                
                sut = XCBuild(systemExecutableProvider: system, terminalWorker: terminal)
            }
            
            context("build and test") {
                
                beforeEach {
                    xcbuildExecutable.argumentsReturnValue = Arguments([""])
                    system.executableWithReturnValue = try? FileProtocolMock()
                    
                    terminal.runProcessClosure = { process in
                        return ["mocked process response success"]
                    }
                    expect { try sut?.buildAndTest(using: xcbuildExecutable) }.toNot(throwError())
                }
                
                it("call terminal") {
                    expect(terminal.runProcessCalled) == true
                }
               
            }
            
            context("get possible destinations") {
                
                let expected = "{mocked destination}"
                
                beforeEach {
                    xcbuildExecutable.argumentsReturnValue = Arguments([""])
                    system.executableWithReturnValue = try? FileProtocolMock()
                    
                    terminal.runProcessClosure = { process in
                        return [expected]
                    }
                }
                
                it("returns detinations") {
                    expect { try sut?.findPosibleDestinations(for: "bla", in: try FolderProtocolMock()) } == [expected]

                }
                
            }
        }
    }
}
