import Foundation
import POSIX
import Url
import ZFile
import Errors
import SourceryAutoProtocols

public protocol PathEnvironmentParserProtocol: AutoMockable {
    // sourcery:inline:PathEnvironmentParser.AutoGenerateProtocol
    static var shared: PathEnvironmentParserProtocol  { get }
    var urls: [FolderProtocol] { get }
    // sourcery:end
}

/// Parser that extracts urls from a String-Array of paths.
/// Usually used to parse the contents of the PATH-environment
/// variable. Any component (PATH=comp1:comp2:...) equal to "."
/// is subsituted by $cwd. Furthermore: Any component which only
/// contains a "." is used as an input to Absolute.init:. (which
/// standardizes the path).
public struct PathEnvironmentParser: PathEnvironmentParserProtocol {

    public static let shared: PathEnvironmentParserProtocol = try! PathEnvironmentParser()
    
    public var urls: [FolderProtocol]

    // MARK: - Init

    public init(
        processInfoEnvironment: [String: String] = ProcessInfo.processInfo.environment
    ) throws
    {
        guard let path = processInfoEnvironment["PATH"] else { throw "\(PathEnvironmentParser.self) \(#function) \(HighwayError.processInfoMissingPath(processInfo: processInfoEnvironment))" }
        
        let paths: [String] = path.components(separatedBy: ":")
        
        urls = try paths.compactMap { return try Folder(path: $0) }
        
    }

}
