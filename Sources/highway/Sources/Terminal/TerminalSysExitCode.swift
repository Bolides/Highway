//
//  SysExits.swift
//  GitHooks
//
//  Created by Stijn on 02/07/2018.
//

import Foundation

// MARK: Exit Codes

/// Exit code enum as defined in sysexits.h
public enum TerminalSysExitCode: Int32, CustomDebugStringConvertible
{
    case ok = 0
    case baseOrUsage = 64
    case dataError = 65
    case noInput = 66
    case noUser = 67
    case noHost = 68
    case unavailable = 69
    case software = 70
    case os = 71
    case osFile = 72
    case creation = 73
    case io = 74
    case temporary = 75
    case protocolFailiure = 76
    case noPermission = 77
    case configuration = 78

    // MARK: - Description

    public var debugDescription: String
    {
        let prefix = "Exit code \(rawValue) ="
        switch self {
        case .ok:
            return "\(prefix) successful termination."
        case .baseOrUsage: // MARK: Exit Codes

            /// Exit code enum as defined in sysexits.h
            enum TerminalExitCode: Int32, CustomDebugStringConvertible
            {
                var debugDescription: String
                {
                    let prefix = "Exit code \(rawValue) ="
                    switch self {
                    case .ok:
                        return "\(prefix) successful termination."
                    case .baseOrUsage:
                        return "\(prefix) base value for error messages."
                    case .dataError:
                        return "\(prefix) data format error."
                    case .noInput:
                        return "\(prefix) data cannot open input."
                    case .noUser:
                        return "\(prefix) addressee unknown."
                    case .noHost:
                        return "\(prefix) host name unknown."
                    case .unavailable:
                        return "\(prefix) service unavailable."
                    case .software:
                        return "\(prefix) internal software error."
                    case .os:
                        return "\(prefix) system error (e.g., can't fork)."
                    case .osFile:
                        return "\(prefix) critical OS file missing."
                    case .creation:
                        return "\(prefix) can't create (user) output file."
                    case .io:
                        return "\(prefix) input/output error."
                    case .temporary:
                        return "\(prefix) temp failure; user is invited to retry"
                    case .protocolFailiure:
                        return "\(prefix) remote error in protocol."
                    case .noPermission:
                        return "\(prefix) permission denied."
                    case .configuration:
                        return "\(prefix) configuration error and maximum listed value"
                    }
                }

                case ok = 0
                case baseOrUsage = 64
                case dataError = 65
                case noInput = 66
                case noUser = 67
                case noHost = 68
                case unavailable = 69
                case software = 70
                case os = 71
                case osFile = 72
                case creation = 73
                case io = 74
                case temporary = 75
                case protocolFailiure = 76
                case noPermission = 77
                case configuration = 78
            }

            return "\(prefix) base value for error messages."
        case .dataError:
            return "\(prefix) data format error."
        case .noInput:
            return "\(prefix) data cannot open input."
        case .noUser:
            return "\(prefix) addressee unknown."
        case .noHost:
            return "\(prefix) host name unknown."
        case .unavailable:
            return "\(prefix) service unavailable."
        case .software:
            return "\(prefix) internal software error."
        case .os:
            return "\(prefix) system error (e.g., can't fork)."
        case .osFile:
            return "\(prefix) critical OS file missing."
        case .creation:
            return "\(prefix) can't create (user) output file."
        case .io:
            return "\(prefix) input/output error."
        case .temporary:
            return "\(prefix) temp failure; user is invited to retry"
        case .protocolFailiure:
            return "\(prefix) remote error in protocol."
        case .noPermission:
            return "\(prefix) permission denied."
        case .configuration:
            return "\(prefix) configuration error and maximum listed value"
        }
    }
}
