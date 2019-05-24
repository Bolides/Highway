
# Highway 
> Test - Integrate - Build status: [@dooZdev ![Build Status](https://app.bitrise.io/app/74c2194000b08d9d/status.svg?token=IqTwBXnTwOzE2pc1p3-aHw)](https://app.bitrise.io/app/74c2194000b08d9d) [@Bolides ![Build Status](https://app.bitrise.io/app/02016c93faf5b17b/status.svg?token=-WGqOL_RvB5Ir43fRaMd0g&branch=master)](https://app.bitrise.io/app/02016c93faf5b17b)

## Develop on Highway

``` bash
swift build --configuration release --static-swift-stdlib 
# will output where the executable is build, usually
./.build/x86_64-apple-macosx10.10/release/HWSetup
# after running this sourcery is setup too and you can generate code when needed
```
# Used Highway in your project

If you do not yet have a `Package.swift` run `swift package init`

add `.package(url: "https://www.github.com/doozMen/Highway", from: "2.3.0")`

do `swift build`

choose frameworks to add. For example HWSetup runs sourcery for highway, swiftformat and performs tests.

Let's take the exampel or running sourcery

``` swift
/**
  Class can be aded to package in target and product.
  You can run it from a main function you create
*/
public struct <#Project#>Sourcery
{
    public static let name = "\(<#Project#>Sourcery.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["Highway"]
    )
}

public let packageDependencies = 
public let package = Package(
    name: "<#Project#>Sourcery",
    products: [<#Project#>Sourcery.product],
    dependencies: [.package(url: "https://www.github.com/Bolides/Highway", "2.10.6" ..< "3.0.0"),],
    targets:[<#Project#>Sourcery.target]
)
```

A possible main function could be

```

import Arguments
import Errors
import Foundation
import Git
import GitHooks
import Highway
import HighwayDispatch
import SignPost
import SourceryWorker
import SwiftFormatWorker
import Terminal
import XCBuild
import ZFile

// MARK: - PREPARE

let highwayRunner: HighwayRunner!
let dispatchGroup: HWDispatchGroupProtocol = DispatchGroup()
let signPost = SignPost.shared

// MARK: - RUN

let dependencyService: DependencyServiceProtocol!

do
{
    let srcRoot = try File(path: #file).parentFolder().parentFolder().parentFolder()
    dependencyService = DependencyService(in: srcRoot)

    // Swift Package

    let dumpService = DumpService(swiftPackageFolder: srcRoot)
    let package = try Highway.package(for: srcRoot, dependencyService: dependencyService, dumpService: dumpService)

    let sourceryBuilder = SourceryBuilder(dependencyService: dependencyService)
    let highway = try Highway(package: package, dependencyService: dependencyService, sourceryBuilder: sourceryBuilder, gitHooksPrePushExecutableName: "HWSetup")

    highwayRunner = HighwayRunner(highway: highway, dispatchGroup: dispatchGroup)

    //    // Githooks

    highwayRunner.runSourcery(handleSourceryOutput)

    dispatchGroup.notifyMain
    {
        highwayRunner.runSwiftformat(handleSwiftformat)
        dispatchGroup.wait()

        guard let errors = highwayRunner.errors, errors.count > 0 else
        {
            signPost.message("🚀 \(HighwayRunner.self) ✅")
            exit(EXIT_SUCCESS)
        }

        signPost.message("🚀 \(HighwayRunner.self) has \(errors.count) ❌")

        for error in errors.enumerated()
        {
            let message = """
            ❌ \(error.offset + 1)
            
            \(error.element)
            
            ---
            
            """
            signPost.error(message)
        }

        exit(EXIT_FAILURE)
    }
    dispatchMain()
}
catch
{
    signPost.error("\(error)")
    exit(EXIT_FAILURE)
}

```

Then you can build this with `swift build`. Any other products you add to your swift package will get sourcery updates if you run the `<#Project#>Sourcery`.

🚀 Done
