
# Highway 
> Test - Integrate - Build status: [@dooZdev ![Build Status](https://app.bitrise.io/app/74c2194000b08d9d/status.svg?token=IqTwBXnTwOzE2pc1p3-aHw)](https://app.bitrise.io/app/74c2194000b08d9d) [@Bolides ![Build Status](https://app.bitrise.io/app/02016c93faf5b17b/status.svg?token=-WGqOL_RvB5Ir43fRaMd0g&branch=master)](https://app.bitrise.io/app/02016c93faf5b17b)


The goal is to make the test and setup run on a build server also run before every push you do. So highway can be used on your dev machine, build server both for macOS and Linux (untested -> [#26](https://github.com/dooZdev/Highway/issues/26) ).

## What do you have to have

For now it is only tested on macOS with xcode 10.1 and swift version 4.2.1 installed. Linux and swift 5 are in the pipeline but currently on hold until this version is stable. 

Follow up

* swift 5 support [#26](https://github.com/dooZdev/Highway/issues/26)
* linux support [#28](https://github.com/dooZdev/Highway/issues/28)

So for now you need to have installed

* macOS 10.13 or higher
* [Homebrew 2.1.3](https://github.com/Homebrew/brew)
* [swift version 4.2.1](https://www.swift.org) this is the version that comes with official release of xcode 10.1

## Use

To use in your own project you need to add it to your swift package. Highway is build to be used as a library you can use to build executables for you project. If you know [fastlane](https://github.com/fastlane/fastlane) you could think of every executable as lane you can run.

To get started you could do the following steps below. By the end you have a generic Highway lane to run any available terminal program you have on your system, wether it is installed or not.

So we will add 2 executables and 1 library in an example swift package



```bash

# go to your project or a fresh folder

swift package init
# will setup the 
```

## Setup Highway

After cloning 

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
