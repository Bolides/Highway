
import Foundation
import Arguments
import SignPost
import Terminal

let automateSourceryWorker: AutomateHighwaySourceryWorkerProtocol?
let disk: SwiftPackageProtocol?
let signPost = SignPost.shared

do {
    disk = try SwiftPackageService().swiftPackage
    
    automateSourceryWorker = try AutomateHighwaySourceryWorker(disk: disk!)
    automateSourceryWorker?.attempt{ asyncResult in
        do {

            let result = try asyncResult()
            signPost.message("\(result.joined(separator: "\n"))")
            exit(EXIT_SUCCESS)
        } catch {
            signPost.error("\(error)")
            exit(EXIT_FAILURE)
        }
    }
} catch {
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}

RunLoop.main.run()
