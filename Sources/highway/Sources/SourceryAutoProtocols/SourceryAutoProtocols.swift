//
//  AutoMockable.swift
//  VRTNieuws
//
//  Created by Stijn on 15/03/2018.
//  Copyright © 2018 VRT. All rights reserved.
//

import Foundation

public protocol AutoMockable {}

@objc public protocol AutoObjcMockable {}

public protocol AutoGenerateProtocol {}

public protocol AutoGenerateSelectiveProtocol {}

public protocol AutoEquatable {}

// MARK: Enums

public protocol AutoCases {}

// MARK: - Sourcery Errors

public enum SourceryMockError: Swift.Error, Hashable
{
    case implementErrorCaseFor(String)
    case subclassMockBeforeUsing(String)

    public var debugDescription: String
    {
        switch self {
        case let .implementErrorCaseFor(message):
            return """
            🧙‍♂️ SourceryMockError.implementErrorCaseFor:
            message: \(message)
            """
        case let .subclassMockBeforeUsing(message):
            return """
            \n
            🧙‍♂️ SourceryMockError.subclassMockBeforeUsing:
            message: \(message)
            """
        }
    }
}
