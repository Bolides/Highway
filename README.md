# Highway

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
