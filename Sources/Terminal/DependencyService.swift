//
//  SwiftPackageService.swift
//  Highway
//
//  Created by Stijn on 06/03/2019.
//

import Arguments
import Errors
import Foundation
import SourceryAutoProtocols
import ZFile

public protocol DependenciesServiceProtocol: AutoMockable
{
    // sourcery:inline:DependenciesService.AutoGenerateProtocol
    var dependency: DependencyProtocol { get }

    init(
        terminal: TerminalWorkerProtocol
    ) throws
    func writeToStubFile() throws
    // sourcery:end
}

public struct DependencyService: DependenciesServiceProtocol, AutoGenerateProtocol
{
    public let dependency: DependencyProtocol

    private let data: Data

    // sourcery:includeInitInProtocol
    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared) throws
    {
        do
        {
            let task = try Task(commandName: "swift")
            task.arguments = Arguments(["package", "show-dependencies", "--format", "json"])

            let output: String = try terminal.runProcess(task.toProcess).joined()
            data = output.data(using: .utf8)!

            do
            {
                dependency = try JSONDecoder().decode(Dependency.self, from: data)
            }
            catch
            {
                let location = "\(DependencyService.self) \(#function) \(#line)"
                let error = HighwayError.swiftPackageShowDependencies(output)
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
