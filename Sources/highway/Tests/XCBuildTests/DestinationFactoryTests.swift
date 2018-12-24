import Quick
import Nimble

import XCBuild

final class DestinationFactoryTests: QuickSpec {

    override func spec() {
        super.spec()
        
        describe("DestinationFactory") {
            
            var sut: DestinationFactory!

            beforeEach {
                sut = DestinationFactory()
            }

            context("macos") {
                it("contains some arrays") {
                    expect(sut.macOS(architecture: .i386).raw) == ["arch" : "i386", "platform" : "macOS"]
                    expect(sut.macOS(architecture: .x86_64).raw) == ["arch" : "x86_64", "platform" : "macOS"]
                }
            }

        }
    }
    
}
