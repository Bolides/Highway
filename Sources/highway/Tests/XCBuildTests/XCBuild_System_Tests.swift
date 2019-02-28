import Nimble
import Quick

import Task
import TaskMock
import XCBuild
import TerminalMock
import Arguments

class XCBuildSpec: QuickSpec {
    
    override func spec() {
        
        describe("XCBuild") {
            
            var sut: XCBuild?
            
        
            var terminal: TerminalWorkerProtocolMock!
            var xcbuildExecutable: ArgumentExecutableProtocolMock!
            var system: SystemProtocolMock!
            
            beforeEach {
                xcbuildExecutable = ArgumentExecutableProtocolMock()
                terminal = TerminalWorkerProtocolMock()
                system = SystemProtocolMock()
                
                sut = XCBuild(system: system, terminalWorker: terminal)
            }
            
            context("build and test") {
                
                beforeEach {
                    xcbuildExecutable.argumentsReturnValue = Arguments([""])
                    system.taskNamedReturnValue = TaskProtocolMock()
                    
                    expect { try sut?.buildAndTest(using: xcbuildExecutable) }.toNot(throwError())
                }
                
                it("call terminal") {
                    expect(terminal.runExecutableCalled) == true
                }
               
            }
        }
    }
}
