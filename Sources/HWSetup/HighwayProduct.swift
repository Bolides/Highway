//
//  HighwayProduct.swift
//  HWSetup
//
//  Created by Stijn on 07/03/2019.
//

import Foundation

public enum HighwayProduct: String, CaseIterable, Decodable
{
    case Arguments
    case Git
    case SourceryWorker
    case Terminal
    case Url
    case XCBuild
    case Errors
    case POSIX
    case Task
    case SwiftFormatWorker
    case HWSetup
    case CarthageWorker
    case GitHooks
    case HighwayDispatch
    case Stub
}
