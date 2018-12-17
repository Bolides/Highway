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
3. `open 🛣.xcodeproj`
4. `run Automate`
5. open terminal and run `.build.nosync/Debug/Automate.app/Contents/MacOS/Automate 🤖command:sourcery`

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
4.3 Verify that you can use all Highway frameworks by making sourcery run

3. Add button to run sourcery in storyboard
	3.1 Open Main.storyboard
	3.2 Add NSButton
	3.3 Add action in ViewController
	3.4 Add dependencies to Automation target & ViewController

		3.4.1 In Target settings add SourceryWorker as a Target depency and link. In the Linked frameworks add ZFile too. (Not needed as target dependency as it should have been build by now)
		3.4.2 In ViewController add imports
			```Swift
			import ZFile
			import SourceryWorker
			import os
			```
		3.4.3 If you have not already add the build output to your framework search path, best is to do it in project settings and use $inherited later.
> As an example you could add the code below to run sourcery.

```Swift
 		func runSourcery() {
        do {
            try setupSourceryWorker()
        } catch {
            os_log(.error, "❌\n %@\n", "\(error)")
        }
    }

    // MARK: - Sourcery Setup

    private func setupSourceryWorker() throws {

        let currentFolder = FileSystem().currentFolder
        os_log(.debug, "💁🏻‍♂️ Running in folder\n %@\n", "\(currentFolder)")

        let sourcesFolder = try currentFolder.parentFolder().parentFolder()
        let carthageFolder = try sourcesFolder.subfolder(named: "Carthage")
        os_log(.debug, "💁🏻‍♂️ Carthage in folder\n %@\n", "\(carthageFolder)")

        let demoFolder = try sourcesFolder.subfolder(named: "Demo")
        os_log(.debug, "💁🏻‍♂️ Demo in folder\n %@\n", "\(demoFolder)")

        let highwayFolder = try Folder(relativePath: "Checkouts/highway", to: carthageFolder)

        let sourcery = try Sourcery(
            templateFolder: try Folder(relativePath: "Checkouts/template-sourcery/sources/stencil", to: carthageFolder),
            outputFolder: try demoFolder.subfolder(named: "AutoGeneratedCode"),
            sourceFolder: demoFolder.subfolder(named: "Models"),
            sourceryAutoProtocolsFile: try highwayFolder.file(named: "/Sources/🧙‍♂️/AutoProtocols/SourceryAutoProtocols.swift")
        )

        let sourceryWorker = try SourceryWorker(sourcery: sourcery)

        os_log(.debug, "🧙‍♂️ Sourcery ran with output\n %@\n", "\(try sourceryWorker.attempt().joined(separator: "\n"))")
    }
```
4. Set sourcery paths to your liking. Use output in console to guide you if you used the example code above.

5. Try running automate from command line

	5.1 Before this can work all dependencies should be embedded in the application. Go to Automate target and verify that the following list is embedded
	*List of frameworks to embed*
	```
	/* Begin PBXCopyFilesBuildPhase section */
			FDEC120121C6869C00CB7DAD /* Embed Frameworks */ = {
				isa = PBXCopyFilesBuildPhase;
				buildActionMask = 2147483647;
				dstPath = "";
				dstSubfolderSpec = 10;
				files = (
					FDEC121121C687E600CB7DAD /* Errors.framework in Embed Frameworks */,
					FD11267C21C689AF0072607D /* Deliver.framework in Embed Frameworks */,
					FDEC120521C686B700CB7DAD /* SourceryWorker.framework in Embed Frameworks */,
					FDEC121D21C688EE00CB7DAD /* Url.framework in Embed Frameworks */,
					FDEC120721C686E200CB7DAD /* SourceryAutoProtocols.framework in Embed Frameworks */,
					FDEC121921C688D600CB7DAD /* Result.framework in Embed Frameworks */,
					FDEC120921C6871900CB7DAD /* Terminal.framework in Embed Frameworks */,
					FD11267821C689AF0072607D /* Keychain.framework in Embed Frameworks */,
					FDEC120321C686AF00CB7DAD /* Arguments.framework in Embed Frameworks */,
					FDEC122121C688F900CB7DAD /* XCBuild.framework in Embed Frameworks */,
					FDEC122521C6890500CB7DAD /* Git.framework in Embed Frameworks */,
					FD1126E221C77F060072607D /* SignPost.framework in Embed Frameworks */,
					FDEC121521C688B600CB7DAD /* POSIX.framework in Embed Frameworks */,
					FDEC120F21C6876B00CB7DAD /* Task.framework in Embed Frameworks */,
				);
				name = "Embed Frameworks";
				runOnlyForDeploymentPostprocessing = 0;
			};
	/* End PBXCopyFilesBuildPhase section */
	```
	5.2 Run from command Line

	```bash
	cd <Project root>
	.build.nosync/Debug/Automate.app/Contents/MacOS/Automate 🤖command:sourcery
	```
> This should output sourcery succes and quit the app.
