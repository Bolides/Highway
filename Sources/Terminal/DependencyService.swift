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

    func generateDependency() throws -> DependencyProtocol
    // sourcery:end
}

public class DependencyService: DependencyServiceProtocol, AutoGenerateProtocol
{
    // MARK: - Private

    private var terminal: TerminalProtocol
    private var signPost: SignPostProtocol
    private var folder: FolderProtocol
    private var system: SystemProtocol

    // MARK: - Init

    public init(in folder: FolderProtocol, system: SystemProtocol = System.shared, terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared)
    {
        self.terminal = terminal
        self.signPost = signPost
        self.folder = folder
        self.system = system
    }

    // MARK: - Functions

    public func generateDependency() throws -> DependencyProtocol
    {
        do
        {
            let task = try system.process("swift")
            task.arguments = ["package", "show-dependencies", "--format", "json"]
            task.currentDirectoryPath = folder.path

            let all = try terminal.runProcess(task)
            let warnings = all.filter { $0.hasPrefix("warning") }
            let json = all.filter { !$0.hasPrefix("warning") }
            let output: String = json.joined()

            guard let data = output.data(using: .utf8) else
            {
                throw HighwayError.highwayError(atLocation: "\(DependencyService.self) \(#function) \(#line)", error: "missing valid data")
            }

            if warnings.count > 0 {
                signPost.message("""
                ⚠️ \(warnings.count) warnings in \(DependencyService.self) \(#function)
                \(warnings.enumerated().map { " \($0.offset) \($0.element)" }.joined(separator: "\n"))
                """)
            }
            do
            {
                signPost.verbose("\(json.joined(separator: "\n"))")
                return try JSONDecoder().decode(Dependency.self, from: data)
            }
            catch
            {
                throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
            }
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(DependencyService.self) \(#function) \(#line)", error: error)
        }
    }
}
