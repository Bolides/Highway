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

1. Add an Macos application to your project named `Automate` 
    > The project Highway contains a Automate target setup like we explan in this use case

2.  I can not work, to my knowledge, in a sandboxed way. So you need to do 2 things:
    2.1 Automate has a .entitlements file. Set sandbox to no 
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <false/>
    </plist>
    ```
    2.3 In build settings set inject base entitlements to no. `CODE_SIGN_INJECT_BASE_ENTITLEMENTS=NO`
4. Build output should be in project folder so the current folder is more convenient
```bash
# Go to build settings and adjust build locations like below
//:configuration = Debug
SYMROOT = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
OBJROOT = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
CONFIGURATION_BUILD_DIR = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
CONFIGURATION_TEMP_DIR = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

//:configuration = Release
SYMROOT = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
OBJROOT = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
CONFIGURATION_BUILD_DIR = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)
CONFIGURATION_TEMP_DIR = $(SRCROOT)/.build.nosync/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)

//:completeSettings = some
SYMROOT
OBJROOT
CONFIGURATION_BUILD_DIR
CONFIGURATION_TEMP_DIR
SHARED_PRECOMPS_DIR

```
4.1 Run automate and see the `.build.nosync` in project root
4.2 Add `.build.nosync` to your `.ignore` (the .nosync is for when you would use icloud to prevent the folder from syncing)
4.3 

3. Add button to run sourcery
    
