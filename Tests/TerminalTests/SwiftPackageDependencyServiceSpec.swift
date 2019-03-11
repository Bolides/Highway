import Quick
import Nimble
import Terminal
import TerminalMock
import Arguments
import Stub
import Foundation
import ZFile

class SwiftPackageDependencyServiceSpec: QuickSpec {
    
    override func spec() {
        
        describe("SwiftPackageDependencyService") {
                        
            var expectedSwiftPackage: SwiftPackageDependenciesProtocol?
            
            beforeSuite {
                // get real dependencies
                expect {
                    let srcroot = try File(path: #file).parentFolder().parentFolder().parentFolder()
                    FileManager.default.changeCurrentDirectoryPath(srcroot.path)
                    expectedSwiftPackage = try SwiftPackageDependencyService().swiftPackage
                    
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
