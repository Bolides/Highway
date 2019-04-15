import Foundation
import SourceryAutoProtocols

public protocol ArgumentsConvertible
{
    func arguments() -> Arguments?
}

public protocol ArgumentsProtocol: AutoMockable
{
    // sourcery:inline:Arguments.AutoGenerateProtocol
    var all: [String] { get set }
    var description: String { get }

    // sourcery:end
}

public struct Arguments: AutoGenerateProtocol
{
    // MARK: - Properties

    public var all: [String]

    // MARK: - Init

    public init(_ all: [String] = CommandLine.arguments)
    {
        self.all = all
    }

    // MARK: - Appending

    // sourcery:begin:skipProtocol
    public mutating func append(_ arg: String)
    {
        append(contentsOf: [arg])
    }

    public mutating func append(contentsOf args: [String])
    {
        all += args
    }

    public mutating func append(_ arguments: Arguments)
    {
        all += arguments.all
    }

    public mutating func appendOption(_ name: String, value: String)
    {
        append(contentsOf: [name, value])
    }

    public mutating func append(_ option: ArgumentsConvertible)
    {
        guard let args = option.arguments() else { return }
        append(args)
    }

    public static func += (lhs: inout Arguments, rhs: ArgumentsConvertible)
    {
        var result = lhs
        result.append(rhs)
        lhs = result
    }

    public static func += (lhs: inout Arguments, rhs: Arguments)
    {
        var result = lhs
        result.append(rhs)
        lhs = result
    }

    public static func += (lhs: inout Arguments, rhs: String)
    {
        var result = lhs
        result.append(rhs)
        lhs = result
    }

    public static func += (lhs: inout Arguments, rhs: [String])
    {
        var result = lhs
        result.append(contentsOf: rhs)
        lhs = result
    }

    public static func + (lhs: Arguments, rhs: Arguments) -> Arguments
    {
        var result = lhs
        result += rhs
        return result
    }

    public static func + (lhs: Arguments, rhs: ArgumentsConvertible) -> Arguments
    {
        var result = lhs
        result += rhs
        return result
    }

    public static func + (lhs: Arguments, rhs: String) -> Arguments
    {
        var result = lhs
        result += rhs
        return result
    }

    // sourcery:end
}

extension Arguments: Equatable
{
    // sourcery:skipProtocol
    public static func == (l: Arguments, r: Arguments) -> Bool
    {
        return l.all == r.all
    }
}

extension Arguments: CustomStringConvertible
{
    public var description: String
    {
        return all.joined(separator: " ")
    }
}

extension Arguments: ExpressibleByArrayLiteral
{
    public init(arrayLiteral elements: String...)
    {
        self.init(elements)
    }
}
