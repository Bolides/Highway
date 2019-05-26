// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - External

let quickNimble: [Target.Dependency] = ["Quick", "Nimble"]
let external: [Package.Dependency] = [
    // MARK: - External Dependencies

    // MARK: - Filesystem

    .package(url: "https://www.github.com/dooZdev/ZFile", "2.4.3" ..< "3.1.0"),

    // MARK: - Sourcery

    .package(url: "https://www.github.com/doozMen/Sourcery", "0.17.0" ..< "1.0.0"),
    .package(url: "https://www.github.com/dooZdev/template-sourcery", "1.4.3" ..< "2.0.0"),

    // MARK: - Errors

    .package(url: "https://www.github.com/antitypical/Result", "4.1.0" ..< "5.1.0"),

    // MARK: - Formatting

    .package(url: "https://github.com/nicklockwood/SwiftFormat", "0.39.4" ..< "0.40.0"),

    // MARK: - Testing

    .package(url: "https://www.github.com/Quick/Quick", "1.3.4" ..< "2.1.0"),
    .package(url: "https://www.github.com/Quick/Nimble", "7.3.4" ..< "8.1.0"),

    // MARK: - Logging

    .package(url: "https://www.github.com/doozMen/SignPost", "1.0.0" ..< "2.0.0"),
]

// MARK: - Executables - Like Lanes in fastlane

/**

  Should be run after you cloned Highway before starting development.
     It will:
 1. Generate mocks
 2. Generate documentation
 3. run tests
 4. generate xcodeproject
 5. Adds lane PR to the .git/pre-push script to be run before every push

 And possibly some other checks. Checkout the terminal output for more info. You can add --verbose to have more output.
 */
public struct Highway
{
    public static let name = "\(Highway.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )

    public struct Library
    {
        public static let nameExtension = "\(Library.self)"

        public static let product = Product.library(
            name: name + nameExtension,
            targets: [name + nameExtension]
        )

        public static let target = Target.target(
            name: Library.product.name,
            dependencies: [
                "SourceryAutoProtocols",
                "SignPost",
                "ZFile",
            ]
                +
                [
                    GitHooks.Library.product.asDependency(),
                    Terminal.library.asDependency(),
                    SourceryWorker.library.asDependency(),
                    SwiftFormatWorker.product.asDependency(),
                    HighwayDispatch.library.asDependency(),
                    Secrets.Library.product.asDependency(),
                    Documentation.Library.product.asDependency(),
                    Errors.library.asDependency(),
                ]
        )

        public static let tests = Target.testTarget(
            name: Library.product.name + "Tests",
            dependencies:
            quickNimble
                + [Library.product.asDependency()]
                + [
                    Secrets.Library.Mock.product.asDependency(),
                    Documentation.Library.Mock.product.asDependency(),
                    SourceryWorker.Mock.library.asDependency(),
                    SwiftFormatWorker.Mock.product.asDependency(),
                    Highway.Library.Mock.product.asDependency(),
                    Terminal.Mock.library.asDependency(),
                    GitHooks.Library.Mock.product.asDependency(),
                    HighwayDispatch.Mock.product.asDependency(),
                ]
                + ["SignPostMock", "ZFileMock"]
        )

        public struct Mock
        {
            public static let nameExtension = "\(Mock.self)"

            public static let product = Product.library(
                name: Library.product.name + Mock.nameExtension,
                targets: [Library.product.name + Mock.nameExtension]
            )

            public static let target = Target.target(
                name: Mock.product.name,
                dependencies: Highway.Library.target.dependencies + [Highway.Library.product.asDependency()],
                path: "Sources/Generated/\(Highway.Library.product.name)"
            )
        }
    }
}

/**
 Highway itself does not have any secrets but this secrets can be added by you if needed.

 It looks at any secret you added with git-secret add <#file#>
 Because bitrise does not support git-secret for now all the secrets are also added with gpg --symmetric with dummy passphrase 123

 If you run this a passphrase will be asked. This is 123
 */
public struct Secrets
{
    public static let name = "\(Secrets.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Library.product.asDependency(), Highway.Library.product.asDependency()]
    )

    public struct Library
    {
        public static let nameExtension = "Library"

        public static let product = Product.library(
            name: name + nameExtension,
            targets: [name + nameExtension]
        )

        public static let target = Target.target(
            name: Library.product.name,
            dependencies: [
                "ZFile",
                "SourceryAutoProtocols",
                "SignPost",
                "Terminal",
                "Errors",
            ]
        )

        public static let tests = Target.testTarget(
            name: name + "Tests",
            dependencies: [product.asDependency()] + quickNimble
        )

        public struct Mock
        {
            public static let name = Library.product.name + "Mock"

            public static let product = Product.library(
                name: Library.product.name + "Mock",
                targets: [name]
            )

            public static let target = Target.target(
                name: name,
                dependencies: Library.target.dependencies + [Library.product.asDependency()],
                path: "Sources/Generated/\(Secrets.Library.product.name)"
            )
        }
    }
}

/**
 Will be used to run on .git/hooks/pre-push and on bitrise for PR's
 It has the same dependencies as HWSetup but does not generate an xcode project and some other setup code.
 */
public struct PR
{
    public static let name = "\(PR.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )
}

/**
 Sourcery is a lovely tool. For now the tool is only used by Highway to generate mocks of any library in the swift package.
 It makes sure the generated mocks have the needed imports by looking at the dependcies defined ing the Mock target.

 Output can be found per libary in a folder with the library name in Sources/<#library name#>
 */
public struct HighwaySourcery
{
    public static let name = "\(HighwaySourcery.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )
}

/**
 Can be used as a Library or as an executable
 */
public struct GitHooks
{
    public static let name = "\(GitHooks.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )
    public static let target = Target.target(
        name: name,
        dependencies: [GitHooks.Library.product.asDependency()]
    )

    public struct Library
    {
        public static let name = GitHooks.name + "Library"

        public static let product = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies: [
                Terminal.library.asDependency(),
                Errors.library.asDependency(),
            ]
        )

        public static let tests = Target.testTarget(
            name: name + "Tests",
            dependencies:
            [product.asDependency()]
                + quickNimble
        )

        public struct Mock
        {
            public static let name = GitHooks.Library.name + "Mock"

            public static let product = Product.library(
                name: name,
                targets: [name]
            )

            public static let target = Target.target(
                name: name,
                dependencies:
                GitHooks.Library.target.dependencies
                    + Terminal.target.dependencies
                    + [GitHooks.Library.product.asDependency()],
                path: "Sources/Generated/\(GitHooks.Library.product.name)"
            )
        }
    }
}

// MARK: - Documentation

public struct Documentation
{
    public static let name = "\(Documentation.self)"

    public static let executable = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Documentation.Library.product.asDependency()]
    )

    public struct Library
    {
        public static let nameExtension = "Library"

        public static let product = Product.library(
            name: name + nameExtension,
            targets: [name + nameExtension]
        )

        public static let target = Target.target(
            name: Library.product.name,
            dependencies: [
                "ZFile",
                "SourceryAutoProtocols",
                "SignPost",
                "Terminal",
                "Errors",
            ]
        )

        public static let tests = Target.testTarget(
            name: name + "Tests",
            dependencies:
            [Library.product.asDependency()]
                + quickNimble
        )

        public struct Mock
        {
            public static let name = Documentation.Library.product.name + "Mock"

            public static let product = Product.library(
                name: Documentation.Library.product.name + "Mock",
                targets: [name]
            )

            public static let target = Target.target(
                name: name,
                dependencies: Library.target.dependencies + [Library.product.asDependency()],
                path: "Sources/Generated/\(Documentation.Library.product.name)"
            )
        }
    }
}

// MARK: - Mainly internal use but you can use libraries in your lanes

public struct CarthageWorker
{
    public static let name = "\(CarthageWorker.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Terminal.library.asDependency()]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [library.asDependency()]
            + quickNimble
            + [
                Highway.Library.Mock.product.asDependency(),
                CarthageWorker.Mock.product.asDependency(),
            ]
    )

    public struct Mock
    {
        public static let name = library.name + "Mock"

        public static let product = Product.library(
            name: library.name + "Mock",
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            CarthageWorker.target.dependencies
                + Terminal.target.dependencies
                + [CarthageWorker.library.asDependency()],
            path: "Sources/Generated/\(CarthageWorker.library.name)"
        )
    }
}

public struct HighwayDispatch
{
    public static let name = "\(HighwayDispatch.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["SourceryAutoProtocols"]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [HighwayDispatch.library.asDependency()]
            + quickNimble
    )

    public struct Mock
    {
        public static let name = "\(HighwayDispatch.name)Mock"

        public static let product = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies: [HighwayDispatch.library.asDependency()] + HighwayDispatch.target.dependencies,
            path: "Sources/Generated/\(HighwayDispatch.name)"
        )
    }
}

public struct Terminal
{
    public static let name = "\(Terminal.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies:
        ["Result", "ZFile", "SignPost"]
            +
            [
                Errors.library.asDependency(),
                HighwayDispatch.library.asDependency(),
            ]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [Terminal.library.asDependency()]
            + quickNimble
    )

    public struct Mock
    {
        public static let name = Terminal.library.name + "Mock"

        public static let library = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            Terminal.target.dependencies
                + [Terminal.library.asDependency()]
                + ["ZFileMock"]
            ,
            path: "Sources/Generated/\(Terminal.library.name)"
        )
    }
}

public struct Errors
{
    public static let name = "\(Errors.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["ZFile"]
    )
}

public struct SourceryWorker
{
    public static let name = "\(SourceryWorker.self)"

    public static let library = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies:
        [Terminal.library.asDependency()]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [SourceryWorker.library.asDependency()]
            + quickNimble
    )

    public struct Mock
    {
        public static let name = SourceryWorker.library.name + "Mock"

        public static let library = Product.library(
            name: Mock.name,
            targets: [Mock.name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            Terminal.target.dependencies
                + SourceryWorker.target.dependencies
                + [
                    SourceryWorker.library.asDependency(),
                ],
            path: "Sources/Generated/\(SourceryWorker.library.name)"
        )
    }
}

public struct SwiftFormatWorker
{
    public static let name = "\(SwiftFormatWorker.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies:
        ["SwiftFormat"]
            +
            [Terminal.library.asDependency()]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies:
        [Terminal.library.asDependency()]
            + quickNimble
    )

    public struct Mock
    {
        public static let name = SwiftFormatWorker.product.name + "Mock"

        public static let product = Product.library(
            name: name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies:
            SwiftFormatWorker.target.dependencies
                + Terminal.target.dependencies
                + [SwiftFormatWorker.product.asDependency()],
            path: "Sources/Generated/\(SwiftFormatWorker.product.name)"
        )
    }
}

// MARK: - Product extensions

extension Product
{
    func asDependency() -> Target.Dependency
    {
        return Target.Dependency(stringLiteral: name)
    }
}

// MARK: - Examples

struct Example {
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
    public struct HighwayTests {
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

// MARK: - Package

public let package = Package(
    name: "Highway",
    products: [
        // MARK: - Executable

        Highway.executable,
        Secrets.product,
        HighwaySourcery.executable,
        Documentation.executable,
        PR.executable,
        GitHooks.executable,
        
        // MARK: - Executable Examples - not needed for highway
        
        Example.HighwayTests.executable,

        // MARK: - Library

        Highway.Library.product,
        Secrets.Library.product,
        Secrets.Library.Mock.product,
        Documentation.Library.Mock.product,
        Documentation.Library.product,
        HighwayDispatch.library,
        Terminal.library,
        Errors.library,
        SourceryWorker.library,
        GitHooks.Library.product,
        SwiftFormatWorker.product,
        CarthageWorker.library,

        // MARK: - Library - Mocks

        HighwayDispatch.Mock.product,
        Highway.Library.Mock.product,
        SourceryWorker.Mock.library,
        SwiftFormatWorker.Mock.product,
        Terminal.Mock.library,
        GitHooks.Library.Mock.product,
        CarthageWorker.Mock.product,
    ],
    dependencies: external,
    targets: [
        // MARK: - Executables

        Highway.target,
        Secrets.target,
        HighwaySourcery.target,
        Documentation.target,
        PR.target,
        GitHooks.target,
        
        // MARK: - Executable Examples - not needed for highway
        
        Example.HighwayTests.target,

        // MARK: - Libraries

        Secrets.Library.target,
        Documentation.Library.target,
        Highway.Library.target,
        HighwayDispatch.target,
        Terminal.target,
        Errors.target,
        SourceryWorker.target,
        GitHooks.Library.target,
        SwiftFormatWorker.target,
        CarthageWorker.target,

        // MARK: - Mocks

        Secrets.Library.Mock.target,
        Documentation.Library.Mock.target,
        HighwayDispatch.Mock.target,
        Highway.Library.Mock.target,
        SourceryWorker.Mock.target,
        SwiftFormatWorker.Mock.target,
        Terminal.Mock.target,
        GitHooks.Library.Mock.target,
        CarthageWorker.Mock.target,

        // MARK: - Tests

        Secrets.Library.tests,
        Documentation.Library.tests,
        Highway.Library.tests,
        HighwayDispatch.tests,
        Terminal.tests,
        SourceryWorker.tests,
        SwiftFormatWorker.tests,
        GitHooks.Library.tests,
        CarthageWorker.tests,
    ]
)
