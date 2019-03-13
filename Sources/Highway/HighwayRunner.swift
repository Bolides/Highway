//
//  SPRunner.swift
//  SPHighwaySetup
//
//  Created by Stijn Willems on 13/03/2019.
//

import Foundation

import SourceryAutoProtocols
import Errors
import XCBuild
import Arguments
import Terminal
import SignPost
import ZFile
import HighwayDispatch
import SourceryWorker

public protocol HighwayRunnerProtocol: AutoMockable {
    // sourcery:inline:HighwayRunner.AutoGenerateProtocol
    static var queue: HighwayDispatchProtocol { get }
    var errors: [Swift.Error]? { get set }
    var highway: HighwayProtocol { get }

    func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
    func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
    
    // sourcery:end
}

public class HighwayRunner: HighwayRunnerProtocol, AutoGenerateProtocol {
    
    public typealias SyncTestOutput = () throws -> TestReportProtocol
    
    public static let queue: HighwayDispatchProtocol = DispatchQueue(label: "be.dooz.signpost.sprunner")
   
    // MARK: - Public properties
    
    public lazy var errors: [Swift.Error]? = [Swift.Error]()
    public let highway: HighwayProtocol
    
    // MARK: - Private
    
    private let terminal: TerminalWorkerProtocol
    private let signPost: SignPostProtocol
    private let queue: HighwayDispatchProtocol
    private let dispatchGroup: DispatchGroup
    
    public init(
        highway: HighwayProtocol,
        dispatchGroup: DispatchGroup,
        queue: HighwayDispatchProtocol = HighwayRunner.queue,
        terminal: TerminalWorkerProtocol = TerminalWorker.shared,
        signPost: SignPostProtocol = SignPost.shared
    ) {
        self.terminal = terminal
        self.signPost = signPost
        self.highway = highway
        self.dispatchGroup = dispatchGroup
        self.queue = queue
    }
    
    public func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)  {
        self.highway.packages.forEach {
            test(package: $0, async)
        }
    }
    
    public func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) {
        dispatchGroup.enter()
        highway.sourceryWorkers.forEach { [weak self] worker in
            guard let `self` = self else {
                async { throw "SPRunner released before it could 🧙🏻‍♂️ on \(worker.sourcery.name)" }
                return
            }

            dispatchGroup.enter()
            signPost.message("🧙🏻‍♂️ \(worker.sourcery.name) ...")
            worker.attempt {
                do {
                    let output = try $0()
                    async { return output }
                    self.signPost.message("🧙🏻‍♂️ \(worker.sourcery.name) ✅")
                } catch {
                    let _error = HighwayError.highwayError(atLocation: "\(HighwayRunner.self) \(#function) \(#line) - \(worker.sourcery.name)", error: error)
                    self.addError(_error)
                    async { throw _error }
                    self.signPost.message("🧙🏻‍♂️ \(worker.sourcery.name) ❌")
                }
                self.dispatchGroup.leave()
            }
            
        }
        dispatchGroup.leave()
    }
    
    // MARK: - Test Package
    
    private func addError(_ error: Swift.Error?) {
        if let error = error { self.errors?.append(error) }
    }

    // MARK: - Private
    
    private func test(package: Highway.Package, _ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void) {
        
        let context = (signPost: signPost, addError: addError, terminal: terminal)
        
        dispatchGroup.enter()
        queue.async { [weak self] in
            
            guard let `self` = self else {
                async { throw "SPRunner released before it could finish testing package \(package.name)" }
                return
            }
            
            var _error: Swift.Error?
            
            do {
                FileManager.default.changeCurrentDirectoryPath(try package.dependencies.srcRoot().path)
                
                context.signPost.message("🧪 swift test in  \(package.name) ... ")
                let task = try Task(commandName: "swift")
                task.arguments = Arguments(["test"])
                
                let testReport = TestReport(output: try context.terminal.runProcess(task.toProcess))
                context.signPost.verbose("\(testReport)")
                context.signPost.message("🧪 swift test in  \(package.name) ✅")
                async { return testReport }
            } catch  TerminalWorker.Error.unknownTask(errorOutput: let output) {
                let testReport = TestReport(output: output)
                _error = HighwayError.failedToCompleteTask("🧪 \(package.name) ❌ \n\(testReport)"
                )
                async { throw _error! }
            } catch {
                _error = HighwayError.highwayError(
                    atLocation: "\(HighwayRunner.self) \(#function) \(#line) - \(package.name)",
                    error: error
                )
                async { throw _error! }
            }
            context.addError(_error)
            
            self.dispatchGroup.leave()
        }
    }
}
