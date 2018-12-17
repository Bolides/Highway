//
//  Import.swift
//  SourceryWorker
//
//  Created by Stijn on 17/12/2018.
//

import Foundation
import SourceryAutoProtocols

public protocol ImportProtocol: AutoMockable {
    /// sourcery:inline:Import.AutoGenerateProtocol
    var name: Set<String> { get }
    var template: String { get }
    /// sourcery:end
}

public struct Import: Hashable, AutoGenerateProtocol {
    
    public let name: Set<String>
    public let template: String
    
    public init(
        name: Set<String>,
        template: String
    ) {
        self.name = name
        self.template = template
    }
    
}
