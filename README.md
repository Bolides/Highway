# Frameworks to help Automate build scripts written in Swift

... Currently exploring how to use this. Very experimental state.

## GOAL of highway

This changed from the original project

1. Build frameworks you can use to write a script in swift that runs Terminal commands
2. Building with xcbuild from swift code
3. Optimize git workflow from Swift
4. Generate reliable code using sourcery with a swift command


# Usage

First resolve some dependencies from the xcode project

1. `carthage update --no-build --use-submodules`
2. `open Carthage/Checkouts/zfile/sources/ZFile.xcodeproj`
	2.1 `build zfile for macos`// This will output the framework in derived data build folder
	2.2 (optional) `build zfile for iOS` // Not used in this project
3. `open 🛣.xcodeproj`
4. `build Task framework`

## Integrate in your project

Use [Carthage](https://www.github.com/Carthage/Carthage)

1. Add Cartfile with > `github "doozMen/highway" "master"` // ⚠️ change master to a tag to fix on a version
2. `carthage update --no-build --use-submodules`
3. Build the frameworks via xcode or `carthage build``
4. Set the **framework search path** to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)` in the project settings, ⚠️ so not in the target. In the target(s) use `$inherited`

The goal is not to provide an out of the box script. You use the different frameworks to automate your workflow.

# Example use cases

Run sourcery to generate protocols.

1. Add an Macos application to your project
