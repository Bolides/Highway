import Terminal
import SignPost
import Errors
import Foundation

let terminal = Terminal.shared
let signPost = SignPost.shared
let system = System.shared

do {
    signPost.message("\(pretty_function()) ...")
    
    let swiftTest = try system.process("swift")
    swiftTest.arguments = ["test"]
    
    let output = try terminal.runProcess(swiftTest)
    let testReport = try TestReport(output: output)
    
    signPost.message("\(testReport)")
    signPost.message("\(pretty_function()) ✅")
    exit(EXIT_SUCCESS)
} catch {
    signPost.error("\(error)")
     signPost.message("\(pretty_function()) ❌")
    exit(EXIT_FAILURE)
}
