//: [Previous](@previous)

import Foundation
// import SwiftFormat
import SwiftFormatWorker
import PlaygroundSupport
import ZFile
import os
import Darwin.POSIX
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

//CLI.print = { message, type in
//    switch type {
//    case .info:
//        os_log(.info, "💁🏻‍♂️ \n%@\n", message)
//    case .success:
//        os_log(.info, "💁🏻‍♂️ \n%@\n", message)
//    case .error:
//        os_log(.error, "🌋 \n%@\n", message)
//    case .warning:
//        os_log(.debug, "⚠️ \n%@\n", message)
//    case .content:
//        os_log(.info, "💁🏻‍♂️ \n%@\n", message)
//    }
//}

do {
    
    // /Users/doozmen/Documents/dooZ/Babylon/ios-babylon-application/Sources/Carthage/Checkouts/highway/Sources/highway/.swiftformat.md
    let folder = try Folder(path: "/Users/doozmen/Documents/dooZ/Babylon/ios-babylon-application/Sources/Carthage/Checkouts/highway/Sources/highway")
    let config = try folder.file(named: ".swiftformat.md")
    
    let worker = SwiftFormatWorker()
    
//
//    DispatchQueue(label: "be.dooz.swiftformat").async {
//
//            print(">> Starting in \(folder.path)...")
//            let arguments = ["--config", config.path]
//            CLI.run(in: folder.path, with: arguments)
//
//            print(">> ✅")
//
//            PlaygroundPage.current.finishExecution()
//    }
} catch {
    print(error)
}



//: [Next](@next)
