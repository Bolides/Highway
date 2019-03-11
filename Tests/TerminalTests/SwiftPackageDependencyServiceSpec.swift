import Quick
import Nimble
import Terminal
import TerminalMock
import Arguments
import Stub

class SwiftPackageDependencyServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("SwiftPackageDependencyService") {
            
            var sut: SwiftPackageDependencyService?
            
            var terminal: TerminalWorkerProtocolMock!
            var expectedSwiftPackage: SwiftPackageDependenciesProtocol?
            
            beforeEach {
                terminal = TerminalWorkerProtocolMock()
                terminal.runProcessClosure = { _ in
                    return swiftPackageShowDependencies.components(separatedBy: "\n")
                }
                expect {
                    sut = try SwiftPackageDependencyService(terminal: terminal)
                    expectedSwiftPackage = sut?.swiftPackage
                    return true
                }.toNot(throwError())
            }
            
            it("have dependencies of Highway package") {
                expect(expectedSwiftPackage?.dependencies.map { $0.name }.sorted()) == ["Nimble",
                                                                                        "Quick",
                                                                                        "Result",
                                                                                        "SignPost",
                                                                                        "Sourcery",
                                                                                        "SwiftFormat",
                                                                                        "ZFile",
                                                                                        "template-sourcery"]
            }
            
            context("its dependencies have dependencies") {
                
                it("ZFile") {
                    let zfile = expectedSwiftPackage?.dependencies.first { $0.name == "ZFile" }
                    expect(zfile?.dependencies.map { $0.name}.sorted()) == ["Nimble",
                                                                            "Quick",
                                                                            "SignPost",
                                                                            "template-sourcery"]
                }
            }
        }
    }
}
