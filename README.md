
# Highway 
> Test - Integrate - Build status: [@dooZdev ![Build Status](https://app.bitrise.io/app/74c2194000b08d9d/status.svg?token=IqTwBXnTwOzE2pc1p3-aHw)](https://app.bitrise.io/app/74c2194000b08d9d) [@Bolides ![Build Status](https://app.bitrise.io/app/02016c93faf5b17b/status.svg?token=-WGqOL_RvB5Ir43fRaMd0g&branch=master)](https://app.bitrise.io/app/02016c93faf5b17b)


The goal is to make the test and setup run on a build server also run before every push you do. So highway can be used on your dev machine, build server both for macOS and Linux (untested -> [#26](https://github.com/dooZdev/Highway/issues/26) ).

For now it is only tested on macOS with xcode 10.1 and swift version 4.2.1 installed. Linux and swift 5 are in the pipeline but currently on hold until this version is stable. 

Follow up

* swift 5 support [#26](https://github.com/dooZdev/Highway/issues/26)
* linux support [#28](https://github.com/dooZdev/Highway/issues/28)

So for now you need to have installed

* macOS 10.13 or higher
* [Homebrew 2.1.3](https://github.com/Homebrew/brew)
* [swift version 4.2.1](https://www.swift.org) this is the version that comes with official release of xcode 10.1

## Documentation

Limited generated documentation is available per library in the folder docs.

Generating documentation can be done 

```bash
swift build --product HighwayDocumentation --configuration release
.build/x86_64-apple-macosx10.10/release/HighwayDocumentation
```

## Use

To use in your own project you need to add it to your swift package. Highway is build to be used as a library you can use to build executables for you project. If you know [fastlane](https://github.com/fastlane/fastlane) you could think of every executable as lane you can run.

To get started you could do the following steps below. By the end you have a generic Highway lane to run any available terminal program you have on your system.

In the swift package you will find the following example struct

```swift
// MARK: - Examples

struct Example
{
    /**
     Highway uses executables as the products you define to generate code or do some continuous integration.
     An executable can be taught of like a lane in fastlane. It has a main and imports libraries from Highway to perform its tasks

     The following example lane tests runs the tests and interprets the output in a TestReport.

     Steps to add HighwayTests executable
     1. add struct like HighwayTests with your project name to your swift package
     2. add static properties exectable to products and target to target of swift package

     Run `swift package generate-xcodeproj --xcconfig-overrides Sources/macOS.xcconfig`

     Open the xcode project and put your code in Sources/HighwayTests
     */
    public struct HighwayTests
    {
        public static let name = "\(HighwayTests.self)"

        public static let executable = Product.executable(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies: [Terminal.library.asDependency()]
        )
    }
}
```

The code in main looks like

```swift
import Errors
import Foundation
import SignPost
import Terminal

let terminal = Terminal.shared
let signPost = SignPost.shared
let system = System.shared

do
{
    signPost.message("\(pretty_function()) ...")

    let swiftTest = try system.process("swift")
    swiftTest.arguments = ["test"]

    let output = try terminal.runProcess(swiftTest)
    let testReport = try TestReport(output: output)

    signPost.message("\(testReport)")
    signPost.message("\(pretty_function()) ✅")
    exit(EXIT_SUCCESS)
}
catch
{
    signPost.error("\(error)")
    signPost.message("\(pretty_function()) ❌")
    exit(EXIT_FAILURE)
}

```

#### Use Highway in your project

If you do not yet have a `Package.swift` run `swift package init`

add `.package(url: "https://www.github.com/doozMen/Highway", from: "2.3.0")`

do `swift build`

choose frameworks to add. For example HWSetup runs sourcery for highway, swiftformat and performs tests.

Let's take the example or running sourcery

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


Then you can build this with `swift build`. Any other products you add to your swift package will get sourcery updates if you run the `<#Project#>Sourcery`.

🚀 Done

---

# Contribute to Highway


After cloning 

``` bash
swift build --configuration release --static-swift-stdlib 
# will output where the executable is build, usually
./.build/x86_64-apple-macosx10.10/release/Highway
# after running this sourcery is setup too and you can generate code when needed
```

Open the generated Highway.xcodeproj or open the folder in any other tool like VSCode and send us a PR.

Thanks!

---

# Projects using highway

* Opensforyou.com
* Bolides.be
* https://www.vrt.be/vrtnws iOS mobile application ! Uses a very early version of highway and not sure if it is still used.
