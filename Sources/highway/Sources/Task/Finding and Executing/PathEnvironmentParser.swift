import Errors
import Foundation
import POSIX
import SignPost
import SourceryAutoProtocols
import Url
import ZFile

public protocol PathEnvironmentParserProtocol: AutoMockable
{
    /// sourcery:inline:PathEnvironmentParser.AutoGenerateProtocol
    var urls: [FolderProtocol] { get }
    /// sourcery:end
}

/// Parser that extracts urls from a String-Array of paths.
/// Usually used to parse the contents of the PATH-environment
/// variable. Any component (PATH=comp1:comp2:...) equal to "."
/// is subsituted by $cwd. Furthermore: Any component which only
/// contains a "." is used as an input to Absolute.init:. (which
/// standardizes the path).
public struct PathEnvironmentParser: PathEnvironmentParserProtocol
{
    public static let shared: PathEnvironmentParser = PathEnvironmentParser()
    public var urls: [FolderProtocol]

    // MARK: - Init

    public init(
        processInfoEnvironment: [String: String] = ProcessInfo.processInfo.environment,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        do
        {
            signPost.verbose("\(PathEnvironmentParser.self) \(#function)")
            guard let path = processInfoEnvironment["PATH"] else { throw "\(PathEnvironmentParser.self) \(#function) \(HighwayError.processInfoMissingPath(processInfo: processInfoEnvironment))" }

            let paths: [String] = path.components(separatedBy: ":")

            signPost.verbose("\(PathEnvironmentParser.self) \(#function) found path \(path)")

            urls = try paths.compactMap { try Folder(path: $0) }
        }
        catch
        {
            signPost.error("⚠️ \(PathEnvironmentParser.self) \(#function) no PATH found, initializing without urls to search for commands")
            urls = [FolderProtocol]()
        }
    }
}
