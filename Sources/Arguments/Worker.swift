import Foundation

public enum Worker: String, Equatable, Hashable, CaseIterable
{
    public static let commandPrefix = "🤖command:"

    case sourcery
    case swiftformat
}
