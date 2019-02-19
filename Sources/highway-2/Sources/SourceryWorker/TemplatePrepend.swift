//
//  Import.swift
//  SourceryWorker
//
//  Created by Stijn on 17/12/2018.
//

import Foundation
import SourceryAutoProtocols

public protocol TemplatePrependProtocol: AutoMockable
{
    /// sourcery:inline:TemplatePrepend.AutoGenerateProtocol
    var names: Set<TemplatePrepend.Import> { get }
    var template: String { get }
    /// sourcery:end
}

public protocol ImportProtocol: AutoMockable
{
    /// sourcery:inline:TemplatePrepend.Import.AutoGenerateProtocol
    var name: String { get }
    var testable: Bool { get }
    /// sourcery:end
}

public struct TemplatePrepend: Hashable, TemplatePrependProtocol, AutoGenerateProtocol
{
    public let names: Set<TemplatePrepend.Import>
    public let template: String

    public struct Import: Hashable, AutoGenerateProtocol
    {
        public let name: String
        public let testable: Bool

        public init(
            name: String,
            testable: Bool = false
        )
        {
            self.name = name
            self.testable = testable
        }
    }

    public init(
        name: Set<Import>,
        template: String
    )
    {
        names = name
        self.template = template
    }
}
