//
//  DocumentationWorker.swift
//  Highway
//
//  Created by Stijn Willems on 22/05/2019.
//

import Arguments
import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol DocumentationWorkerProtocol: AutoMockable
{
    // sourcery:inline:DocumentationWorker.AutoGenerateProtocol

    func attemptJazzyDocs(in folder: FolderProtocol, for dump: DumpProtocol) throws -> [String]

    // sourcery:end
}

public struct DocumentationWorker: DocumentationWorkerProtocol, AutoGenerateProtocol
{
    // MARK: - Private

    private let terminal: TerminalProtocol
    private let system: SystemProtocol
    private let signPost: SignPostProtocol

    // MARK: - Init

    public init(
        terminal: TerminalProtocol = Terminal.shared,
        system: SystemProtocol = System.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.terminal = terminal
        self.system = system
        self.signPost = signPost
    }

    // MARK: - Attempt to generate Docs

    /// Performs `jazzy -x -scheme,Highway-Package -m <#product#> --output docs/<#product#>` for every product in the swift package
    public func attemptJazzyDocs(in folder: FolderProtocol, for dump: DumpProtocol) throws -> [String]
    {
        do
        {
            signPost.message("\(pretty_function()) checking ruby install ...")
            let rbenv = try system.rbenvProcess(in: folder)
            rbenv.arguments = ["install", "-l"]

            let rbenvOutput = try terminal.runProcess(rbenv)
            signPost.message("\(rbenvOutput.joined(separator: "\n")) ")
            signPost.message("\(pretty_function()) checking ruby install ✅")

            signPost.verbose("\(pretty_function()) ...")

            let products = dump.products

            let jazzyName = "jazzy"
            var jazzy = try system.installOrFindGemProcess(name: jazzyName, in: folder)

            try products.forEach
            { product in
                signPost.message("\(pretty_function()) jazzy \(product) ...")

                jazzy = try system.gemProcess(name: "jazzy", in: folder)
                jazzy.arguments = ["-x", "-scheme,Highway-Package", "-m", "\(product)", "--output", "docs/\(product)"]

                let output = try terminal.runProcess(jazzy)
                signPost.verbose(output.joined(separator: "\n"))
                signPost.message("\(pretty_function()) jazzy \(product) ✅")
            }

            return ["\(pretty_function()) ✅"]
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
