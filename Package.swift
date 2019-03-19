// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

public let package = Package(
    name: "Highway",
    products: [
        // MARK: - Executable

        .executable(
            name: "HWSetup",
            targets: ["HWSetup"]
        ),

        // MARK: - Library

        .library(
            name: "HWCarthage",
            targets: ["HWCarthage"]
        ),

        .library(
            name: "HWPod",
            targets: ["HWPod"]
        ),
        .library(
            name: "Highway",
            targets: ["Highway"]
        ),
        .library(
            name: "Errors",
            targets: ["Errors"]
        ),
        .library(
            name: "HighwayDispatch",
            targets: ["HighwayDispatch"]
        ),

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
        .library(
            name: "Terminal",
            targets: ["Terminal"]
        ),
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

        .library(
            name: "HighwayDispatchMock",
            targets: ["HighwayDispatchMock"]
        ),
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
            name: "HighwayMock",
            targets: ["HighwayMock"]
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
    dependencies: [
        // MARK: - External Dependencies

        // MARK: - Filesystem

        .package(url: "https://www.github.com/Bolides/ZFile", "2.2.0" ..< "3.1.0"),

        // MARK: - Sourcery

        .package(url: "https://www.github.com/doozMen/Sourcery", "0.16.3" ..< "1.0.0"),
        .package(url: "https://www.github.com/dooZdev/template-sourcery", "1.3.7" ..< "2.0.0"),

        // MARK: - Errors

        .package(url: "https://www.github.com/antitypical/Result", "4.1.0" ..< "5.1.0"),

        // MARK: - Formatting

        .package(url: "https://github.com/nicklockwood/SwiftFormat", "0.39.4" ..< "0.40.0"),

        // MARK: - Testing

        .package(url: "https://www.github.com/Quick/Quick", "1.3.4" ..< "2.1.0"),
        .package(url: "https://www.github.com/Quick/Nimble", "7.3.4" ..< "8.1.0"),

        // MARK: - Logging

        .package(url: "https://www.github.com/doozMen/SignPost", "1.0.0" ..< "2.0.0"),

    ],
    targets: [
        // MARK: - Targets

        .target(
            name: "HWCarthage",
            dependencies: ["SourceryAutoProtocols", "Highway", "ZFile", "SignPost", "Terminal"]
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
            name: "Highway",
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
        .target(
            name: "Terminal",
            dependencies: ["HWPOSIX", "Arguments", "Errors"]
        ),
        .target(
            name: "Git",
            dependencies: ["Terminal", "Url", "Arguments", "Errors"]
        ),

        .target(
            name: "SourceryWorker",
            dependencies: ["Terminal", "HighwayDispatch", "Errors"]
        ),
        .target(
            name: "SwiftFormatWorker",
            dependencies: ["Errors", "Arguments", "ZFile", "SwiftFormat", "HighwayDispatch"]
        ),
        .target(
            name: "HighwayDispatch",
            dependencies: ["Errors", "SignPost"]
        ),
        .target(
            name: "Stub",
            dependencies: []
        ),

        // MARK: - Mocks

        .target(
            name: "HWCarthageMock",
            dependencies: ["HighwayDispatch", "HWCarthage", "SignPost", "ZFileMock", "ZFile", "SourceryAutoProtocols", "Errors"],
            path: "Sources/Generated/HWCarthage"
        ),
        .target(
            name: "HWPodMock",
            dependencies: ["HighwayDispatch", "HWPod", "SignPost", "ZFileMock", "SourceryAutoProtocols", "Errors"],
            path: "Sources/Generated/HWPod"
        ),
        .target(
            name: "HighwayDispatchMock",
            dependencies: ["HighwayDispatch", "SignPost", "ZFileMock", "SourceryAutoProtocols", "Errors"],
            path: "Sources/Generated/HighwayDispatch"
        ),
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
            dependencies: ["Terminal", "ZFile", "ZFileMock", "Arguments", "SourceryAutoProtocols", "SignPost"],
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
        .target(
            name: "HighwayMock",
            dependencies: [
                "Highway",
                "SourceryAutoProtocols",
                "SignPost",
                "Arguments",
                "SourceryWorker",
                "HighwayDispatch",
                "GitHooks",
                "SwiftFormatWorker",
                "SignPost",
            ],
            path: "Sources/Generated/Highway"
        ),

        // MARK: - Tests

        .testTarget(
            name: "HWCarthageTests",
            dependencies: ["HWCarthage", "ArgumentsMock", "HighwayMock", "HighwayDispatchMock", "HWCarthageMock", "Quick", "Nimble"]
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
                "HWSetup",
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
        .target(
            name: "HWSetup",
            dependencies: [
                "Arguments",
                "Errors",
                "SignPost",
                "SourceryAutoProtocols",
                "SourceryWorker",
                "SwiftFormatWorker",
                "Terminal",
                "ZFile",
                "XCBuild",
                "GitHooks",
                "Highway",
            ]
        ),
        .testTarget(
            name: "HighwayTests",
            dependencies: [
                "Nimble",
                "Quick",
                "ArgumentsMock",
                "Highway",
                "HighwayDispatchMock",
                "HighwayMock",
                "SignPostMock",
                "SourceryWorker",
                "SourceryWorkerMock",
                "SwiftFormatWorkerMock",
                "Terminal",
                "TerminalMock",
                "ZFileMock",
                "GitHooksMock",
            ]
        ),
    ]
)
