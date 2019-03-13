import Arguments
import ArgumentsMock

import Nimble
import Quick

class ArgumentsSpec: QuickSpec
{
    override func spec()
    {
        describe("ArgumentsTests")
        {
            var sut: Arguments?

            beforeEach
            {
                sut = Arguments()
            }

            it("should have default arguments from command line")
            {
                expect(sut?.all).to(contain(["-srcRoot", "/../../../../../../../"]))
            }
        }
    }
}
