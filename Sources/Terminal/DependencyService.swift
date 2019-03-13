//
//  SwiftPackageService.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile

public protocol DependencyServiceProtocol: AutoMockable
{
    // sourcery:inline:DependencyService.AutoGenerateProtocol
    var dependency: DependencyProtocol { get }

    init(
        terminal: TerminalWorkerProtocol,
        signPost: SignPostProtocol
    ) throws
    func writeToStubFile() throws
    // sourcery:end
}

public struct DependencyService: DependencyServiceProtocol, AutoGenerateProtocol
{
    public let dependency: DependencyProtocol

    private let data: Data

    // sourcery:includeInitInProtocol
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared, signPost: SignPostProtocol = SignPost.shared) throws
    {
        do
        {
            let task = try Task(commandName: "swift")
            task.arguments = Arguments(["package", "show-dependencies", "--format", "json"])

            let all = try terminal.runProcess(task.toProcess)
            let warnings = all.filter { $0.hasPrefix("warning") }
            let json = all.filter { !$0.hasPrefix("warning") }
            let output: String = json.joined()

            data = output.data(using: .utf8)!

            if warnings.count > 0 {
                signPost.message("""
                ⚠️ \(warnings.count) warnings in \(DependencyService.self) \(#function)
                \(warnings.enumerated().map { " \($0.offset) \($0.element)" }.joined(separator: "\n"))
                """)
            }
            do
            {
                signPost.verbose("\(json.joined(separator: "\n"))")
                dependency = try JSONDecoder().decode(Dependency.self, from: data)
            }
            catch
            {
                signPost.verbose("\(output)")
                let location = "\(DependencyService.self) \(#function) \(#line)"
                let error = HighwayError.swiftPackageShowDependencies("\(error)")
                throw HighwayError.highwayError(atLocation: location, error: error)
            }
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(DependencyService.self) \(#function) \(#line)", error: error)
        }
    }

    public func writeToStubFile() throws
    {
        let stubFile = try dependency.srcRoot().subfolder(named: "Sources/Stub").createFileIfNeeded(named: "\(DependencyService.self).json")
        try stubFile.write(data: data)
    }
}
