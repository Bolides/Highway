import Errors
import Foundation
import POSIX
import SignPost
import SourceryAutoProtocols
import Url
import ZFile
import SignPost
import Arguments

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
        highwayCommandLineArguments: HighwayCommandLineOption.Values = HighwayCommandLineOption.Values(),
        processInfoEnvironment: [String: String] = ProcessInfo.processInfo.environment,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        let pathFromCommandline = highwayCommandLineArguments.ordered.compactMap { $0.path }.first
        
        {
            if pathFromCommandline != nil {
                signPost.message("\(PathEnvironmentParser.self) \(#function) \n⚠️ using path from command line argument \(HighwayCommandLineOption.SingleOption.path("your path"))")
            }
            
            guard let path = pathFromCommandline == nil ? processInfoEnvironment["PATH"] : pathFromCommandline! else {
                throw "\(PathEnvironmentParser.self) \(#function) \(HighwayError.processInfoMissingPath(processInfo: processInfoEnvironment))"
            }

            let paths: [String] = path.components(separatedBy: ":")
            
            signPost.message("\(PathEnvironmentParser.self) \(#function) found path \n\(paths.map { "* \($0)"}.joined(separator: "\n"))")
            
            urls = try paths.compactMap { try Folder(path: $0) }
        }
        catch
        {
            signPost.error("⚠️ \(PathEnvironmentParser.self) \(#function) no PATH found, initializing without urls to search for commands")
            urls = [FolderProtocol]()
        }
    }
}
