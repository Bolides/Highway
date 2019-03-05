import Foundation

public enum HighwayCommandLineOption: String, CaseIterable
{
    case srcRoot
    case _srcRoot = "-srcRoot"
    case __srcRoot = "--srcRoot"
    case srcroot
    case _srcroot = "-srcroot"
    case _path = "-path"

    // MARK: - Enum

    public enum SingleOption
    {
        case srcroot(String)
        case path(String)

        public var srcRoot: String?
        {
            switch self
            {
            case let .srcroot(root):
                return root
            default:
                return nil
            }
        }

        public var path: String?
        {
            switch self
            {
            case let .path(path):
                return path
            default:
                return nil
            }
        }
    }

    // MARK: - Structs

    public struct Values: CustomStringConvertible
    {
        public let ordered: [HighwayCommandLineOption.SingleOption]

        public init(arguments: [String] = CommandLine.arguments)
        {
            var ordered = [HighwayCommandLineOption.SingleOption]()

            arguments.forEach
            { argument in
                guard
                    let option = HighwayCommandLineOption(rawValue: argument),
                    let optionIndex = arguments.firstIndex(of: option.rawValue) else
                {
                    return
                }
                let nextIndex = optionIndex + 1
                let value = arguments[nextIndex]

                switch option
                {
                case .__srcRoot, ._srcRoot, .srcRoot, ._srcroot, .srcroot:
                    ordered.append(.srcroot(value))
                case _path:
                    ordered.append(.path(value))
                }
            }

            self.ordered = ordered
        }

        public var description: String
        {
            return """
            \(ordered.map { "  * \($0)" }.joined(separator: "\n"))
            """
        }
    }
}
