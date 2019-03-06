// swift-tools-version:4.2
import PackageDescription

let package = Package(name: "HighwaySetup")

package.products = [
    .executable(name: "HighwaySetup", targets: ["HighwaySetup"])
]
package.dependencies = [
    .package(url: "https://github.com/doozMen/SignPost.git", from: "1.0.0"),
    .package(url: "https://github.com/doozMen/Highway.git", from: "2.2.0"),
    .package(url: "https://www.github.com/doozMen/template-sourcery", from: "1.2.0"),
    .package(url: "https://www.github.com/doozMen/ZFile", from: "2.0.1"),
    .package(url: "https://www.github.com/doozMen/Sourcery", from: "0.16.2")
]
package.targets = [
    .target(name: "HighwaySetup", dependencies: ["Arguments", "Errors", "SwiftFormatWorker", "Terminal", "ZFile", "SourceryWorker", "SourceryAutoProtocols", "ZFile", "SignPost"], path: "Sources")
]
