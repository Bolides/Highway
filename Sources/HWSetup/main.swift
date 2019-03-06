
import Foundation
import Arguments
import SignPost
import Terminal

let automateSourceryWorker: AutomateHighwaySourceryWorkerProtocol?
let disk: DiskProtocol?
let signPost = SignPost.shared

do {
    let package = try SwiftPackageService().swiftPackage
    
    automateSourceryWorker = try AutomateHighwaySourceryWorker(disk: package, queue: DispatchQueue.main)
    automateSourceryWorker?.attempt{ asyncResult in
        do {

            let result = try asyncResult()
            signPost.message("\(result.joined(separator: "\n"))")
            exit(EXIT_SUCCESS)
        } catch {
            exit(EXIT_FAILURE)
        }
    }
} catch {
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
