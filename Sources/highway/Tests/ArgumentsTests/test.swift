import Arguments
import ArgumentsMock

import Quick
import Nimble

class ArgumentsSpec: QuickSpec {
    
    override func spec() {
        
        describe("ArgumentsTests") {
            
            var sut: Arguments?
            
            beforeEach {
                sut = Arguments()
            }
            
            it("should have default arguments from command line") {
                expect(sut?.all) == ["srcroot mocked test argument from scheme"]
            }
        }
    }
}
