import Foundation

public enum Worker: String, Equatable, Hashable {
    
    public static let commandPrefix = "🤖command:"
    
    case sourcery
    
    public static func allCases() -> String {
        return """
        case sourcery
        """
    }
    
}
