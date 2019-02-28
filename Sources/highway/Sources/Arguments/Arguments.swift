import Foundation

public protocol ArgumentsConvertible
{
    func arguments() -> Arguments?
}

public struct Arguments
{
    // MARK: - Properties

    public var all: [String]

    // MARK: - Init

    public init(_ all: [String] = (HighwayCommandLineOption.Values().optionsAndValues.map { "\($0.key) \($0.value)" }))
    {
        self.all = all
    }

    // MARK: - Appending

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
}

extension Arguments: Equatable
{
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
