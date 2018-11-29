# Usage

First resolve some dependencies from the xcode project

1. `carthage update --no-build --use-submodules`
2. `carthage build`
3. `open 🛣.xcodeproj`

## Integrate in your project

Use [Carthage](https://www.github.com/Carthage/Carthage)

1. Add Cartfile with
> `github "doozMen/highway" "master"` // ⚠️ change master to a tag to fix on a version
2. `carthage update --no-build --use-submodules`
3. Build the frameworks via xcode or `carthage build``
4. Set the **framework search path** to where you build the frameworks
(optional) 5. If you build an app make sure to embed the framework.

## What can you do?

1. Run terminal commands from Swift
2. Use XCBuild in Swift

... Currently exploring how to use this. Very experimental state.
