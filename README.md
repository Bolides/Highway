
# Highway 
> Test - Integrate - Build status: [@dooZdev ![Build Status](https://app.bitrise.io/app/74c2194000b08d9d/status.svg?token=IqTwBXnTwOzE2pc1p3-aHw)](https://app.bitrise.io/app/74c2194000b08d9d) [@Bolides ![Build Status](https://app.bitrise.io/app/02016c93faf5b17b/status.svg?token=-WGqOL_RvB5Ir43fRaMd0g&branch=master)](https://app.bitrise.io/app/02016c93faf5b17b)

## Develop on Highway

``` bash
swift build --product HWSetup -c release --static-swift-stdlib
# will output where the executable is build, usually
./.build/x86_64-apple-macosx10.10/release/HWSetup
# after running this sourcery is setup too and you can generate code when needed
```
# Used Highway in your project

If you do not yet have a `Package.swift` run `swift package init`

add `.package(url: "https://www.github.com/doozMen/Highway", from: "2.3.0")`

do `swift build`

choose frameworks to add. For example HWSetup runs sourcery for highway, swiftformat and performs tests.

``` swift
// Add a target in Package.swift
.target(
            name:   "HWSetup",
            dependencies: [
                    "Arguments",
                    "Errors",
                    "SignPost",
                    "SourceryAutoProtocols",
                    "SourceryWorker",
                    "SwiftFormatWorker",
                    "Terminal",
                    "ZFile"
            ]
```

`swift package generate-xcodeproj`

> You should not add the generated xcode project to git, just use it to Develop

🚀 Done
