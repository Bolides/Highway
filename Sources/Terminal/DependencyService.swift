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
    var dependency: DependencyProtocol? { get set }

    init(
        terminal: TerminalProtocol,
        signPost: SignPostProtocol
    ) throws
    func generateDependency() throws -> DependencyProtocol
    func writeToStubFile() throws
    // sourcery:end
}

extension DependencyServiceProtocol
{
    // MARK: - Static

    public static func generateDepedency(in folder: FolderProtocol, system: SystemProtocol = System.shared, terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared) throws -> (dep: DependencyProtocol, data: Data)
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
                let dependency = try JSONDecoder().decode(Dependency.self, from: data)
                return (dep: dependency, data: data)
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

public class DependencyService: DependencyServiceProtocol, AutoGenerateProtocol
{
    // MARK: - Public

    public var dependency: DependencyProtocol?

    // MARK: - Private

    private var data: Data?
    private var terminal: TerminalProtocol
    private var signPost: SignPostProtocol
    private var srcRoot: FolderProtocol

    // MARK: - Init

    public init(in srcRoot: FolderProtocol, terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared)
    {
        data = nil
        dependency = nil
        self.terminal = terminal
        self.signPost = signPost
        self.srcRoot = srcRoot
    }

    // sourcery:includeInitInProtocol
    public required init(terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared) throws
    {
        self.terminal = terminal
        self.signPost = signPost
        let dep = try DependencyService.generateDepedency(in: FileSystem.shared.currentFolder, terminal: terminal, signPost: signPost)
        dependency = dep.dep
        data = dep.data

        srcRoot = try dependency!.srcRoot()
    }

    // MARK: - Functions

    public func generateDependency() throws -> DependencyProtocol
    {
        let dep = try DependencyService.generateDepedency(in: FileSystem.shared.currentFolder, terminal: terminal, signPost: signPost)
        dependency = dep.dep
        data = dep.data
        return dep.dep
    }

    public func writeToStubFile() throws
    {
        guard let data = data else
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: "missing data")
        }

        let stubFile = try srcRoot.subfolder(named: "Sources/Stub").createFileIfNeeded(named: "\(DependencyService.self).json")
        try stubFile.write(data: data)
    }
}
