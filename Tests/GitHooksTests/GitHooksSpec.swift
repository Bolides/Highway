//
//  GitHooksSpec.swift
//  Highway
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

import Quick
import Nimble
import GitHooks
import ArgumentsMock
import Arguments
import ZFileMock
import Errors

private let expectedPrePushScript = """
#!/bin/sh

# Build setup executable
pushd ../../
swift build --product GitHooksWorkerSpec -c release --static-swift-stdlib

# Execute the script
./.build/x86_64-apple-macosx10.10/release/GitHooksWorkerSpec
popd
# Allow push on success
"""

class GitHooksWorkerSpec: QuickSpec {
    
    override func spec() {
        
        describe("GitHooksWorker") {
            
            var sut: GitHooksWorker?
            
            var gitHooksFolder: FolderProtocolMock!
            var prePushFile: FileProtocolMock!
            var swiftPackageDependencies: SwiftPackageDependenciesProtocolMock!
            var swiftPackageDump: SwiftPackageDumpProtocolMock!
            
            beforeEach {
                gitHooksFolder = try! FolderProtocolMock()
                prePushFile = try! FileProtocolMock()
                
                swiftPackageDependencies = SwiftPackageDependenciesProtocolMock()
                swiftPackageDependencies.gitHooksClosure = { return gitHooksFolder }
                
                swiftPackageDump = SwiftPackageDumpProtocolMock()
                let executable = SwiftProduct(name: "GitHooksWorkerSpec", product_type: "executable")
                swiftPackageDump.products = Set([executable])
                
            }
            
            context("pre-push is still sample") {
                
                beforeEach {
                    prePushFile = try! FileProtocolMock()
                    gitHooksFolder.fileNamedClosure = { filename in
                        
                        if filename == "pre-push.sample" {
                            return prePushFile
                        } else if filename == "pre-push" {
                            throw "handling case of sample"
                        }
                        
                        throw "mock gitHooksFolder has no file for name \(filename)"
                    }
                    
                    
                    sut = GitHooksWorker(swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump)
                    expect { try sut?.addPrePushToGitHooks() }.toNot(throwError())
                }
                
                it("renames") {
                    expect(prePushFile.renameToKeepExtensionReceivedArguments?.newName) == "pre-push"
                    expect(prePushFile.renameToKeepExtensionReceivedArguments?.keepExtension) == false
                }
                
                it("writes script") {
                    expect(prePushFile.writeStringReceivedString) == expectedPrePushScript
                }
                
            }
            
            context("pre-push is not a sample") {
                
                beforeEach {
                    prePushFile = try! FileProtocolMock()
                    gitHooksFolder.fileNamedClosure = { filename in
                        
                        if filename == "pre-push.sample" {
                            throw "handling case of sample"
                        } else if filename == "pre-push" {
                            return prePushFile
                        }
                        
                        throw "mock gitHooksFolder has no file for name \(filename)"
                    }
                    
                    
                    sut = GitHooksWorker(swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump)
                    expect { try sut?.addPrePushToGitHooks() }.toNot(throwError())
                }
                
                it("renames") {
                    expect(prePushFile.renameToCalled) == false
                }
                
                it("writes script") {
                    expect(prePushFile.writeStringReceivedString) == expectedPrePushScript
                }
                
            }
           
        }
    }
}
