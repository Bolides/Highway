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

/**
 Will be used to run on .git/hooks/pre-push and on bitrise for PR's
 It has the same dependencies as HWSetup but does not generate an xcode project and some other setup code.
 */
public struct PR
{
    public static let name = "\(PR.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )
}

public struct HighwayDispatch
{
    public static let name = "\(HighwayDispatch.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["SourceryAutoProtocols"]
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
            dependencies: [HighwayDispatch.dependency] + HighwayDispatch.target.dependencies,
            path: "Sources/Generated/\(HighwayDispatch.name)"
        )
    }

    public static let mock = Mock()
    public static let dependency = Target.Dependency(stringLiteral: name)
}

public struct Terminal
{
    public static let name = "\(Terminal.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["Arguments", "Errors", HighwayDispatch.dependency]
    )
}

public struct Arguments
{
    public static let name = "\(Arguments.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: ["SourceryAutoProtocols"]
    )
}

public struct Errors
{
    public static let name = "\(Errors.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: []
    )
}

public struct SourceryWorker
{
    public static let name = "\(SourceryWorker.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Terminal.product.asDependency()]
    )
}

public struct GitHooks
{
    public static let name = "\(GitHooks.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Terminal.product.asDependency()]
    )
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
        dependencies: [Terminal.product.asDependency()]
    )
}

public struct XCBuild
{
    public static let name = "\(XCBuild.self)"

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Terminal.product.asDependency()]
    )
}

// MARK: - HighwaySourcery

public struct HighwaySourcery
{
    public static let name = "\(HighwaySourcery.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )
}

// MARK: - Documentation

public struct Documentation
{
    public static let name = "\(Documentation.self)"

    public static let product = Product.executable(
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
                "Arguments",
            ]
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

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies: target.dependencies + quickNimble
    )
}

// MARK: - GitSecrets

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

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies: target.dependencies + quickNimble
    )
}

public struct Highway
{
    public static let name = "\(Highway.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: [Highway.Library.product.asDependency()]
    )

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies: [
            Secrets.Library.Mock.product.asDependency(),
            Documentation.Library.Mock.product.asDependency(),
        ]
            + quickNimble
            + [Library.product.asDependency()]
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
                "Terminal",
                "Arguments",
                "SignPost",
                "ZFile",
                "SourceryWorker",
                "HighwayDispatch",
                "GitHooks",
                "SwiftFormatWorker",
                "XCBuild",
                "Errors",
            ]
                +
                [
                    Secrets.Library.product.asDependency(),
                    Documentation.Library.product.asDependency(),
                ]
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

// MARK: - Product extensions

extension Product
{
    func asDependency() -> Target.Dependency
    {
        return Target.Dependency(stringLiteral: name)
    }
}

// MARK: - Package

public let package = Package(
    name: "Highway",
    products: [
        // MARK: - Executable

        Highway.product,
        Secrets.product,
        HighwaySourcery.product,
        Documentation.product,
        PR.product,

        // MARK: - Library

        Highway.Library.product,
        Secrets.Library.product,
        Secrets.Library.Mock.product,
        Documentation.Library.Mock.product,
        Documentation.Library.product,
        HighwayDispatch.product,
        Arguments.product,
        Terminal.product,
        Errors.product,
        SourceryWorker.product,
        GitHooks.product,
        SwiftFormatWorker.product,
        XCBuild.product,

        // MARK: - Library - Mocks

        HighwayDispatch.Mock.product,
        Highway.Library.Mock.product,
    ],
    dependencies: external,
    targets: [
        // MARK: - Executables

        Highway.target,
        Secrets.target,
        HighwaySourcery.target,
        Documentation.target,
        PR.target,

        // MARK: - Libraries

        Secrets.Library.target,
        Documentation.Library.target,
        Highway.Library.target,
        HighwayDispatch.target,
        Arguments.target,
        Terminal.target,
        Errors.target,
        SourceryWorker.target,
        GitHooks.target,
        SwiftFormatWorker.target,
        XCBuild.target,

        // MARK: - Mocks

        Secrets.Library.Mock.target,
        Documentation.Library.Mock.target,

        HighwayDispatch.Mock.target,
        Highway.Library.Mock.target,

        // MARK: - Tests

        Secrets.tests,
        Documentation.tests,
        Highway.tests,
    ]
)
