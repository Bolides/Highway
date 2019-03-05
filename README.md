# Automate development tasks using Swift.

1. Build frameworks you can use to write a script in swift that runs Terminal commands
2. Building with xcbuild from swift code
3. Run terminal commands from swift
4. Generate code using [Sourcery](https://github.com/doozMen/Sourcery)

# Usage

First resolve some dependencies from the xcode project

`carthage checkout`
 To build using xcode do `File>WorkSpace Settings> Build relative to workspace` and set to `../../.build`
 
 > To my knowledge I cannot share this setting, let me know if you know how you can.
 
## Integrate in your project

Use [Carthage](https://www.github.com/Carthage/Carthage)

1. Add Cartfile  `github "doozMen/highway`
2. `carthage update`
3. Embed the  `Sources/highway/Highway.xcodeproj` in workspace or project
4. Set the **framework search path** to `$(BUILD_DIR)/$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)` in the **GENERAL** project settings,
5. Embed all frameworks from  Highway except the iOS versions
6. Embed  `Sources/Carthage/CheckOuts/CupertinoJWT`
8. Embed  `Sources/Carthage/CheckOuts/ZFile`
9. Embed  `Sources/Carthage/CheckOuts/Result`

The goal is not to provide an out of the box script. You use the different frameworks to automate your workflow.

--- 
The rest is extra

## git-secret

The api key to appstore connect is stored via git-secret. run `git-secret reveal` to use it.
