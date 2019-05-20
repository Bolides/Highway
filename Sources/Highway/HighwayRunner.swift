//
//  SPRunner.swift
//  SPHighwaySetup
//
//  Created by Stijn Willems on 13/03/2019.
//

import Foundation

import Arguments
import Errors
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import Terminal
import XCBuild
import ZFile

public protocol HighwayRunnerProtocol: AutoMockable
{
    // sourcery:inline:HighwayRunner.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }
    var errors: [Swift.Error]? { get set }
    var highway: HighwayProtocol { get }

    func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    func addGithooksPrePush() throws
    func runSwiftformat(_ async: @escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void)
    func runSwiftPackageGenerateXcodeProject(_ async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    func hideSecrets()
    func hideSecrets(async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    // sourcery:end
}

public class HighwayRunner: HighwayRunnerProtocol, AutoGenerateProtocol
{
    public typealias SyncTestOutput = () throws -> TestReportProtocol
    public typealias SyncSwiftformat = () throws -> Void
    public typealias SyncSwiftPackageGenerateXcodeProj = () throws -> [String]
    public typealias SyncHideSecret = () throws -> [String]

    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.signpost.sprunner")

    // MARK: - Public properties

    public lazy var errors: [Swift.Error]? = [Swift.Error]()
    public let highway: HighwayProtocol

    // MARK: - Private

    private let terminal: TerminalProtocol
    private let signPost: SignPostProtocol
    private let queue: HighwayDispatchProtocol
    private let dispatchGroup: HWDispatchGroupProtocol
    private let system: SystemProtocol

    public init(
        highway: HighwayProtocol,
        dispatchGroup: HWDispatchGroupProtocol,
        queue: HighwayDispatchProtocol = HighwayRunner.queue,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.highway = highway
        self.dispatchGroup = dispatchGroup
        self.queue = queue
        self.system = system
    }

    public func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    {
        test(package: highway.package, async)
    }

    public func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    {
        do
        {
            try highway.sourceryWorkers?.forEach
            { worker in
                signPost.message("🧙🏻‍♂️ \(worker.name) ...")

                dispatchGroup.enter()
                worker.attempt(in: try worker.sourceryYMLFile.parentFolder())
                { [weak self] in

                    do
                    {
                        let output = try $0()
                        async { output }
                        self?.signPost.message("🧙🏻‍♂️ \(worker.name) ✅")
                    }
                    catch
                    {
                        let _error = HighwayError.highwayError(atLocation: "\(HighwayRunner.self) \(#function) \(#line) - \(worker.name)", error: error)
                        self?.addError(_error)
                        async { throw _error }
                        self?.signPost.message("🧙🏻‍♂️ \(worker.name) ❌")
                    }
                    self?.dispatchGroup.leave()
                }
            }
        }
        catch
        {
            async { throw HighwayError.highwayError(atLocation: pretty_function(), error: error) }
        }
    }

    public func addGithooksPrePush() throws
    {
        try highway.githooks?.addPrePushToGitHooks()
    }

    public func runSwiftformat(_ async: @escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void)
    {
        signPost.message("🧹 swiftformat ...")
        dispatchGroup.enter()
        highway.swiftformat.attempt
        { syncSwiftformatOutput in
            do
            {
                try syncSwiftformatOutput()
                async {}
                self.signPost.message("🧹 swiftformat ✅")
            }
            catch
            {
                self.addError(error)
                async { throw error }
                self.signPost.message("🧹 swiftformat ❌")
            }
            self.dispatchGroup.leave()
        }
    }

    public func runSwiftPackageGenerateXcodeProject(_ async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    {
        signPost.message("🛠 \(pretty_function()) ...")

        dispatchGroup.enter()
        queue.async
        { [weak self] in
            guard let `self` = self else
            {
                async { throw HighwayError.prematureRelease(in: pretty_function()) }
                return
            }

            do
            {
                let task = try self.system.process("swift")
                let config = try self.highway.package.dependencies.srcRoot().subfolder(named: "Sources").createFileIfNeeded(named: "macos.xcconfig")
                try config.write(string: Highway.xcodeConfigOverride.joined(separator: "\n"))

                task.arguments = ["package", "generate-xcodeproj", "--xcconfig-overrides", "Sources/macos.xcconfig"]
                task.currentDirectoryPath = try self.highway.package.dependencies.srcRoot().path

                let output = try self.terminal.runProcess(task)
                self.signPost.message("🛠 \(pretty_function()) ✅")
                async { output }
            }
            catch
            {
                self.signPost.message("🛠 \(pretty_function()) ❌")
                self.addError(error)
                async { throw HighwayError.highwayError(atLocation: pretty_function(), error: error) }
            }

            self.dispatchGroup.leave()
        }
    }

    public func hideSecrets()
    {
        hideSecrets(async: handleHideSecrets)
    }

    public func hideSecrets(async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    {}

    // MARK: - Private

    private func addError(_ error: Swift.Error?)
    {
        if let error = error
        {
            if errors == nil { errors = [Swift.Error]() }
            errors?.append(error)
        }
    }

    private func test(package: PackageProtocol, _ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    {
        let context = (signPost: signPost, addError: addError, terminal: terminal)

        dispatchGroup.enter()
        queue.async
        { [weak self] in
            guard let `self` = self else
            {
                async { throw "SPRunner released before it could finish testing package \(package.name)" }
                return
            }

            var _error: Swift.Error?

            do
            {
                context.signPost.message("🧪 swift test package \(package.name) ... ")
                let task = try self.system.process("swift")
                task.arguments = ["test"] + Highway.swiftCFlags
                task.currentDirectoryPath = try package.dependencies.srcRoot().path

                let testReport = TestReport(output: try context.terminal.runProcess(task))
                context.signPost.verbose("\(testReport)")
                context.signPost.message("🧪 swift test package \(package.name) ✅")
                async { testReport }
            }
            catch let Terminal.Error.unknownTask(errorOutput: output)
            {
                let testReport = TestReport(output: output)
                _error = HighwayError.failedToCompleteTask(
                    "🧪 \(package.name) ❌ \n\(testReport)"
                )

                async { throw _error! }
                context.signPost.message("🧪 swift test package \(package.name) ❌")
            }
            catch
            {
                _error = HighwayError.highwayError(
                    atLocation: "\(HighwayRunner.self) \(#function) \(#line) - \(package.name)",
                    error: error
                )
                async { throw _error! }
                context.signPost.message("🧪 swift test package \(package.name) ❌")
            }
            context.addError(_error)

            self.dispatchGroup.leave()
        }
    }
}
