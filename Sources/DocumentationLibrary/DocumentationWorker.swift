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
    static var shared: DocumentationWorkerProtocol { get }

    func attemptJazzyDocs(in folder: FolderProtocol, for products: Set<SwiftProduct>) throws  -> [String]

    // sourcery:end
}

/// Generates documentation per product you per product you pass to it. the docs are in the docs/<#productName#> folder
/// To view the generated docs you do `open docs/<#productName#>/index.html`
/// > The documentation is still very basic for now. Thanks for updating if you feel like it :).

public struct DocumentationWorker: DocumentationWorkerProtocol, AutoGenerateProtocol
{
    public static let shared: DocumentationWorkerProtocol = DocumentationWorker()

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
    public func attemptJazzyDocs(in folder: FolderProtocol, for products: Set<SwiftProduct>) throws -> [String]
    {
        do
        {
            signPost.message("\(pretty_function()) for \(products.count) ...")
            signPost.verbose(products.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n"))

            let jazzyName = "jazzy"
            var jazzy = try system.installOrFindGemProcess(name: jazzyName, in: folder)

            let total = products.count

            try products.enumerated().forEach
            { product in
                jazzy = try system.gemProcess(name: "jazzy", in: folder)
                signPost.message("\(pretty_function()) jazzy \(product.offset + 1)/\(total) \(product.element.name) ...")

                jazzy.arguments = [
                    "-x",
                    "-scheme,Highway-Package",
                    "-m", "\(product)",
                    "--output", "docs/\(product)",
                    "--xcodebuild-arguments", "-derivedDataPath \(try folder.subfolder(named: ".build").path)",
                    "--swift-version", "4.2.1",
                ]

                let output = try terminal.runProcess(jazzy)
                signPost.verbose(output.joined(separator: "\n"))
                signPost.message("\(pretty_function()) jazzy \n\(product)\n ✅")
            }

            return ["\(pretty_function()) ✅"]
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }
}
