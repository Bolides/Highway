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

public protocol SwiftPackageDependencyServiceProtocol: AutoMockable
{
    // highway:inline:SwiftPackageDependencyService.AutoGenerateProtocol
    var swiftPackage: SwiftPackageDependenciesProtocol { get }
    // highway:end
}

public struct SwiftPackageDependencyService: SwiftPackageDependencyServiceProtocol, AutoGenerateProtocol
{
    public let swiftPackage: SwiftPackageDependenciesProtocol

    public init(terminal: TerminalWorkerProtocol = TerminalWorker.shared) throws
    {
        do
        {
            let task = try Task(commandName: "swift")
            task.arguments = Arguments(["package", "show-dependencies", "--format", "json"])

            let output: String = try terminal.runProcess(task.toProcess).joined()
            let data: Data = output.data(using: .utf8)!

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
}
