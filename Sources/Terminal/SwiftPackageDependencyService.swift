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

public protocol SwiftPackageDependencyServiceProtocol: AutoMockable
{
    // sourcery:inline:SwiftPackageDependencyService.AutoGenerateProtocol
    var swiftPackage: SwiftPackageDependenciesProtocol { get }

    init(
        terminal: TerminalWorkerProtocol
    ) throws
    func writeToStubFile() throws
    // sourcery:end
}

public struct SwiftPackageDependencyService: SwiftPackageDependencyServiceProtocol, AutoGenerateProtocol
{
    public let swiftPackage: SwiftPackageDependenciesProtocol

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
                swiftPackage = try JSONDecoder().decode(SwiftPackageDependencies.self, from: data)
            }
            catch
            {
                let location = "\(SwiftPackageDependencyService.self) \(#function) \(#line)"
                let error = HighwayError.swiftPackageShowDependencies(output)
                throw HighwayError.highwayError(atLocation: location, error: error)
            }
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(SwiftPackageDependencyService.self) \(#function) \(#line)", error: error)
        }
    }

    public func writeToStubFile() throws
    {
        let stubFile = try swiftPackage.srcRoot().subfolder(named: "Sources/Stub").createFileIfNeeded(named: "\(SwiftPackageDependencyService.self).json")
        try stubFile.write(data: data)
    }
}
