
import Foundation
import Arguments
import SignPost

let automateSourceryWorker: AutomateHighwaySourceryWorkerProtocol?
let disk: DiskProtocol?
let signPost = SignPost.shared

do {
    disk = try Disk()
    automateSourceryWorker = try AutomateHighwaySourceryWorker(disk: disk!)
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

RunLoop.main.run()
