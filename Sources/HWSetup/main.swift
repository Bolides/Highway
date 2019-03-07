
import Foundation
import Arguments
import SignPost
import Terminal


let automateSourceryWorker: AutomateHighwaySourceryWorkerProtocol?
let disk: SwiftPackageDependenciesProtocol?
let swiftPackageDump: SwiftPackageDumpProtocol?
let signPost = SignPost.shared
let dispatchGroup = DispatchGroup()

signPost.message("🚀 HWSetup ... ")

do {
    disk = try SwiftPackageDependencyService().swiftPackage
    swiftPackageDump = try SwiftPackageDumpService().swiftPackageDump
    automateSourceryWorker = try AutomateHighwaySourceryWorker(disk: disk!, dispatchGroup: dispatchGroup, swiftPackageDump: swiftPackageDump!)

    let sourceryProducts = swiftPackageDump!.products.map { $0.name }.filter { !$0.hasSuffix("Mock") }
    signPost.message("🧙‍♂️ \(sourceryProducts.count) for \n\(sourceryProducts.enumerated().map { " \($0.offset + 1) \($0.element)" }.joined(separator: "\n"))\n ")

    dispatchGroup.enter()
    automateSourceryWorker?.attempt{ asyncResult in
        do {

            let result = try asyncResult()
            signPost.verbose("\(result.joined(separator: "\n"))")
            dispatchGroup.leave()
        } catch {
            signPost.error("\(error)")
            dispatchGroup.leave()
            exit(EXIT_FAILURE)
        }
    }
    
    dispatchGroup.notify(queue: DispatchQueue.main) {
        signPost.message("🚀 HWSetup ✅")
        exit(EXIT_SUCCESS)
    }
    dispatchMain()
} catch {
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}
