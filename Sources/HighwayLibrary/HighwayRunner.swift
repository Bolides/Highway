//
//  SPRunner.swift
//  SPHighwaySetup
//
//  Created by Stijn Willems on 13/03/2019.
//

import Foundation

import DocumentationLibrary
import Errors
import HighwayDispatch
import SecretsLibrary
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import Terminal

import ZFile

public protocol HighwayRunnerProtocol: AutoMockable
{
    // sourcery:inline:HighwayRunner.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }
    var errors: [Swift.Error]? { get set }
    var highway: HighwayProtocol { get }

    func generateDocs(for products: Set<SwiftProduct>, packageName: String, _ async: @escaping (@escaping HighwayRunner.SyncDocs) -> Void)
    func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    func addGithooksPrePush() throws
    func runSwiftformat(_ async: @escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void)
    func runSwiftPackageGenerateXcodeProject(_ async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
    func checkIfSecretsShouldBeHidden(in folder: FolderProtocol) throws

    // sourcery:end
}

public class HighwayRunner: HighwayRunnerProtocol, AutoGenerateProtocol
{
    public typealias SyncTestOutput = () throws -> TestReportProtocol
    public typealias SyncSwiftformat = () throws -> Void
    public typealias SyncSwiftPackageGenerateXcodeProj = () throws -> [String]
    public typealias SyncHideSecret = () throws -> [String]
    public typealias SyncDocs = () throws -> [String]

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
    private var secretsWorker: SecretsWorkerProtocol
    private let documentationWorker: DocumentationWorkerProtocol

    public init(
        highway: HighwayProtocol,
        dispatchGroup: HWDispatchGroupProtocol,
        queue: HighwayDispatchProtocol = HighwayRunner.queue,
        terminal: TerminalProtocol = Terminal.shared,
        signPost: SignPostProtocol = SignPost.shared,
        system: SystemProtocol = System.shared,
        secretsWorker: SecretsWorkerProtocol = SecretsWorker.shared,
        documentationWorker: DocumentationWorkerProtocol = DocumentationWorker()
    )
    {
        self.terminal = terminal
        self.signPost = signPost
        self.highway = highway
        self.dispatchGroup = dispatchGroup
        self.queue = queue
        self.system = system
        self.secretsWorker = secretsWorker
        self.documentationWorker = documentationWorker
    }

    // MARK: - Documetation

    /**
      Will run documentation on products passed to the function

     - parameters:
         - package: PackageProtocol,
         - products : set of products you want to generate docs for
         - packageName : the swift package you want to generate docs for
         - async : function that can default to handleSyncDocs function if you like to use that. handleSyncDocs is a global function in Highway

     */
    public func generateDocs(for products: Set<SwiftProduct>, packageName: String, _ async: @escaping (@escaping HighwayRunner.SyncDocs) -> Void)
    {
        dispatchGroup.enter()

        queue.async
        { [weak self] in
            guard let `self` = self else { return }

            do
            {
                let output = try self.documentationWorker.attemptJazzyDocs(in: try self.highway.srcRoot(), packageName: packageName, for: products)

                async { output }
            }
            catch
            {
                async { throw error }
            }
        }
    }

    // MARK: - Tests

    public func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    {
        test(package: highway.package, async)
    }

    // MARK: - Sourcery

    /**
     Will run sourcery on every product in the swift package except the once you excluded.
     Adds the imports from the SwiftPackageDescription.Target.dependencies to the generated mock file for every product
     */
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
            addError(error)
            async { throw error }
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

    // MARK: - Secrets

    /** Will throw if secrets changed SecretsWorker.Error.runSecretsExecutable
     */
    public func checkIfSecretsShouldBeHidden(in folder: FolderProtocol) throws
    {
        let secretPaths = try secretsWorker.secretsChangedSinceLastPush(in: folder)

        guard secretPaths.count > 0 else
        {
            signPost.message("\(pretty_function()) no secrets to hide.")
            return
        }
        throw SecretsWorker.Error.runSecretsExecutable(missingFilePaths: secretPaths)
    }

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

            do
            {
                context.signPost.message("🧪 swift test package \(package.name) ... ")
                let task = try self.system.process("swift")
                task.arguments = ["test"] + Highway.swiftCFlags
                task.currentDirectoryPath = try package.dependencies.srcRoot().path

                let testReport = try TestReport(output: try context.terminal.runProcess(task))
                context.signPost.verbose("\(testReport)")
                async { testReport }
                context.signPost.message("🧪 swift test package \(package.name) ✅")
            }
            catch
            {
                self.addError(error)
                async { throw error }
                context.signPost.message("🧪 swift test package \(package.name) ❌")
            }

            self.dispatchGroup.leave()
        }
    }
}
