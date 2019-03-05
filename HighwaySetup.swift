#!/usr/bin/swift sh

import Foundation
import SwiftFormatWorker // @doozMen/highway

firstly {
    after(.seconds(2))
}.then {
    after(.milliseconds(500))
}.done {
    print("notice: two and a half seconds elapsed")
    exit(0)
}

RunLoop.main.run()
