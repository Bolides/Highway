# Automate development tasks using Swift.

1. Build frameworks you can use to write a script in swift that runs Terminal commands
2. Building with xcbuild from swift code
3. Run terminal commands from swift
4. Generate code using [Sourcery](https://github.com/doozMen/Sourcery)

# Usage

First resolve some dependencies from the xcode project

```bash
carthage update --no-build --use-submodules`
xcodebuild -project Sources/highway/Automate🛣.xcodeproj -scheme AutomateHighway

```

## Run from Terminal

 ``` bash
 cd Sources/highway
 <#path to automate app, probably derivedData#>/Automate.app/Contents/MacOS/Automate 🤖command:sourcery
 ```

## Integrate in your project

Use [Carthage](https://www.github.com/Carthage/Carthage)

1. Add Cartfile with > `github "doozMen/highway" "master"` // ⚠️ change master to a tag to fix on a version
2. `carthage update --no-build --use-submodules`
3. Embed the  `🛣.xcodeproj` file in your project like ZFile.xcodeProj is embeded in `🛣.xcodeproj
4. Set the **framework search path** to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)` in the **GENERAL** project settings,

    > ⚠️ so not in the target. In the target(s) use `$inherited`
5. Add **macOS** `Automate` target
6. Embed all frameworks from  Highway except the iOS versions
7. Embed CuportinoJWT (add project from Sources/Carthage/CheckOuts/CupertinoJWT)
8. Embed ZFile (add project from Sources/Carthage/CheckOuts/ZFile)

The goal is not to provide an out of the box script. You use the different frameworks to automate your workflow.

--- 
The rest is extra

## git-secret

The api key to appstore connect is stored via git-secret. run `git-secret reveal` to use it.
