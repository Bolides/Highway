// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let quickNimble: [Target.Dependency] = ["Quick", "Nimble"]

// MARK: - External

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

public struct HWSetup
{
    public static let name = "\(HWSetup.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: "HWSetup",
        dependencies: [
            "Arguments",
            "Errors",
            "Git",
            "GitHooks",
            HighwayDispatch.dependency,
            "SignPost",
            "SourceryWorker",
            "SourceryAutoProtocols",
            "SwiftFormatWorker",
            "Terminal",
            "XCBuild",
            "ZFile",
        ] +
            [
                Highway.product.asDependency(),
            ]
    )
}

/// Will be used to run on .git/hooks/pre-push and on bitrise for PR's
/// It has the same dependencies as HWSetup but does not generate an xcode project and some other setup code.
public struct PR
{
    public static let name = "\(PR.self)"

    public static let product = Product.executable(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
        dependencies: HWSetup.target.dependencies
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
        dependencies: ["HWPOSIX", "Arguments", "Errors", HighwayDispatch.dependency]
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
        dependencies: HWSetup.target.dependencies
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
        dependencies: [Library.product.asDependency(), Highway.product.asDependency()]
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

    public static let product = Product.library(
        name: name,
        targets: [name]
    )

    public static let target = Target.target(
        name: name,
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
        public static let name = Highway.product.name + "Mock"

        public static let product = Product.library(
            name: Mock.name,
            targets: [name]
        )

        public static let target = Target.target(
            name: name,
            dependencies: Highway.target.dependencies + [Highway.product.asDependency()],
            path: "Sources/Generated/\(Highway.product.name)"
        )
    }

    public static let tests = Target.testTarget(
        name: name + "Tests",
        dependencies: [
            Highway.product.asDependency(),
            Secrets.Library.Mock.product.asDependency(),
            Documentation.Library.Mock.product.asDependency(),
        ]
            + quickNimble
    )
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

        HWSetup.product,
        Secrets.product,
        HighwaySourcery.product,
        Documentation.product,
        PR.product,

        // MARK: - Library

        Secrets.Library.product,
        Highway.product,
        Secrets.Library.Mock.product,
        Documentation.Library.Mock.product,
        Documentation.Library.product,

        .library(
            name: "HWCarthage",
            targets: ["HWCarthage"]
        ),

        .library(
            name: "HWPod",
            targets: ["HWPod"]
        ),
        .library(
            name: "Errors",
            targets: ["Errors"]
        ),
        HighwayDispatch.product,

        .library(
            name: "GitHooks",
            targets: ["GitHooks"]
        ),
        .library(
            name: "Arguments",
            targets: ["Arguments"]
        ),
        .library(
            name: "Url",
            targets: ["Url"]
        ),
        .library(
            name: "HWPOSIX",
            targets: ["HWPOSIX"]
        ),
        .library(
            name: "XCBuild",
            targets: ["XCBuild"]
        ),
        Terminal.product,
        .library(
            name: "Git",
            targets: ["Git"]
        ),
        .library(
            name: "SourceryWorker",
            targets: ["SourceryWorker"]
        ),
        .library(
            name: "SwiftFormatWorker",
            targets: ["SwiftFormatWorker"]
        ),
        .library(
            name: "Stub",
            targets: ["Stub"]
        ),

        // MARK: - Library - Mocks

        HighwayDispatch.Mock.product,
        Highway.Mock.product,

        .library(
            name: "SwiftFormatWorkerMock",
            targets: ["SwiftFormatWorkerMock"]
        ),
        .library(
            name: "SourceryWorkerMock",
            targets: ["SourceryWorkerMock"]
        ),
        .library(
            name: "TerminalMock",
            targets: ["TerminalMock"]
        ),
        .library(
            name: "XCBuildMock",
            targets: ["XCBuildMock"]
        ),
        .library(
            name: "ArgumentsMock",
            targets: ["ArgumentsMock"]
        ),
        .library(
            name: "GitHooksMock",
            targets: ["GitHooksMock"]
        ),
        .library(
            name: "HWCarthageMock",
            targets: ["HWCarthageMock"]
        ),
        .library(
            name: "HWPodMock",
            targets: ["HWPodMock"]
        ),

    ],
    dependencies: external,
    targets: [
        // MARK: - Executables

        HWSetup.target,
        Secrets.target,
        HighwaySourcery.target,
        Documentation.target,
        PR.target,

        // MARK: - Libraries

        Secrets.Library.target,
        Highway.target,
        Documentation.Library.target,

        .target(
            name: "HWCarthage",
            dependencies: ["SourceryAutoProtocols", "ZFile", "SignPost", "Terminal"] + [Highway.product.asDependency()]
        ),
        .target(
            name: "HWPod",
            dependencies: ["SourceryAutoProtocols", "ZFile", "SignPost", "Terminal"]
        ),
        .target(
            name: "Errors",
            dependencies: ["SourceryAutoProtocols", "ZFile"]
        ),
        .target(
            name: "Arguments",
            dependencies: ["SourceryAutoProtocols", "ZFile", "SignPost", "Errors"]
        ),
        .target(
            name: "GitHooks",
            dependencies: [
                "SourceryAutoProtocols",
                "ZFile",
                "SignPost",
                "Terminal",
                "Arguments",
                "Errors",
            ]
        ),
        .target(
            name: "Url",
            dependencies: []
        ),
        .target(
            name: "HWPOSIX",
            dependencies: ["Url"]
        ),
        .target(
            name: "XCBuild",
            dependencies: ["Arguments", "Errors", "Url", "HWPOSIX", "Terminal", "Result"]
        ),
        Terminal.target,
        .target(
            name: "Git",
            dependencies: ["Terminal", "Url", "Arguments", "Errors"]
        ),

        .target(
            name: "SourceryWorker",
            dependencies: ["Terminal", "HighwayDispatch", "Errors", "ZFile", "HighwayDispatch", "SourceryAutoProtocols"]
        ),
        .target(
            name: "SwiftFormatWorker",
            dependencies: ["Errors", "Arguments", "ZFile", "SwiftFormat", "HighwayDispatch"]
        ),
        HighwayDispatch.target,
        .target(
            name: "Stub",
            dependencies: []
        ),

        // MARK: - Mocks

        Secrets.Library.Mock.target,
        Documentation.Library.Mock.target,

        .target(
            name: "HWCarthageMock",
            dependencies: ["HighwayDispatch", "HWCarthage", "ZFileMock", "ZFile", "Errors"],
            path: "Sources/Generated/HWCarthage"
        ),
        .target(
            name: "HWPodMock",
            dependencies: ["HighwayDispatch", "HWPod", "ZFileMock", "Errors"],
            path: "Sources/Generated/HWPod"
        ),
        HighwayDispatch.Mock.target,
        .target(
            name: "GitHooksMock",
            dependencies: [
                "SourceryAutoProtocols",
                "ZFile",
                "ZFileMock",
                "SignPost",
                "GitHooks",
                "Terminal",
                "Arguments",
                "SignPost",
                "Errors",
            ],
            path: "Sources/Generated/GitHooks"
        ),
        .target(
            name: "ArgumentsMock",
            dependencies: ["SourceryAutoProtocols", "ZFile", "ZFileMock", "SignPost", "Arguments"],
            path: "Sources/Generated/Arguments"
        ),
        .target(
            name: "XCBuildMock",
            dependencies: ["ZFile", "ZFileMock", "XCBuild", "Arguments", "SignPost"],
            path: "Sources/Generated/XCBuild"
        ),
        .target(
            name: "TerminalMock",
            dependencies: ["Terminal", "ZFile", "ZFileMock", "Arguments", "SignPost"],
            path: "Sources/Generated/Terminal"
        ),
        .target(
            name: "SwiftFormatWorkerMock",
            dependencies: ["SwiftFormatWorker", "ZFileMock", "ZFile", "SwiftFormatWorker", "HighwayDispatch", "SignPost"],
            path: "Sources/Generated/SwiftFormatWorker"
        ),
        .target(
            name: "SourceryWorkerMock",
            dependencies: ["SourceryWorker", "ZFile", "Terminal", "ZFileMock", "TerminalMock", "HighwayDispatch", "Arguments", "SignPost"],
            path: "Sources/Generated/SourceryWorker"
        ),
        Highway.Mock.target,

        // MARK: - Tests

        Secrets.tests,
        Documentation.tests,
        Highway.tests,

        .testTarget(
            name: "HWCarthageTests",
            dependencies: ["HWCarthage", "SignPostMock", "ArgumentsMock", "Arguments", "HighwayMock", "HighwayDispatchMock", "HWCarthageMock", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "HWPodTests",
            dependencies: ["HWPod", "HWPodMock", "ZFileMock", "ZFile", "TerminalMock", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "GitHooksTests",
            dependencies: [
                "GitHooks",
                "Quick",
                "Nimble",
                "ArgumentsMock",
                "ZFileMock",
                "Errors",
                "GitHooksMock",
                "SignPostMock",
            ]
        ),
        .testTarget(
            name: "HWPOSIXTests",
            dependencies: ["HWPOSIX", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "XCBuildTests",
            dependencies: [
                "Terminal",
                "XCBuild",
                "TerminalMock",
                "Arguments",
                "ArgumentsMock",
                "XCBuildMock",
                "ZFileMock",
                "Quick",
                "Nimble",
            ]
        ),
        .testTarget(
            name: "TerminalTests",
            dependencies: ["Terminal", "TerminalMock", "Arguments", "Quick", "Nimble", "Stub"]
        ),
        .testTarget(
            name: "GitTests",
            dependencies: ["Git", "Quick", "Nimble"]
        ),
        .testTarget(
            name: "SourceryWorkerTests",
            dependencies: [
                "SourceryWorker",
                "SignPostMock",
                "SourceryWorkerMock",
                "Quick",
                "Nimble",
                "TerminalMock",
                "SignPostMock",
                "HighwayDispatchMock",
                "ArgumentsMock",
                "Arguments",
                "TerminalMock",
                "Stub",
                "Errors",
            ]
        ),
        .testTarget(
            name: "SwiftFormatWorkerTests",
            dependencies: [
                "SwiftFormatWorker",
                "SwiftFormatWorkerMock",
                "SignPostMock",
                "Quick",
                "Nimble",
                "HighwayDispatchMock",
            ]
        ),
    ]
)
