import Foundation
import SourceryAutoProtocols
import Url
import ZFile

/// Maps names command line tools/executables to file urls.
public protocol SystemExecutableProviderProtocol: AutoMockable
{
    // highway:inline:SystemExecutableProvider.AutoGenerateProtocol
    static var shared: SystemExecutableProviderProtocol { get }
    var pathEnvironmentParser: PathEnvironmentParserProtocol { get }
    var fileSystem: FileSystemProtocol { get }

    func executable(with executableName: String) throws -> FileProtocol
    // highway:end
}

public struct SystemExecutableProvider: SystemExecutableProviderProtocol, AutoGenerateProtocol
{
    public static let shared: SystemExecutableProviderProtocol = SystemExecutableProvider()

    // MARK: - Properties

    public let pathEnvironmentParser: PathEnvironmentParserProtocol
    public let fileSystem: FileSystemProtocol

    // MARK: - Init

    public init(
        pathEnvironmentParser: PathEnvironmentParserProtocol = PathEnvironmentParser.shared,
        fileSystem: FileSystemProtocol = FileSystem.shared
    )
    {
        self.pathEnvironmentParser = pathEnvironmentParser
        self.fileSystem = fileSystem
    }

    // MARKL: - Error

    public enum Error: Swift.Error
    {
        case executableNotFoundFor(executableName: String)
    }
}

// MARK: - ExecutableProviderProtocol

extension SystemExecutableProvider
{
    public func executable(with executableName: String) throws -> FileProtocol
    {
        var _result: FileProtocol?

        for folder in pathEnvironmentParser.urls
        {
            if let executable = (folder.makeFileSequence(recursive: true, includeHidden: true).first { $0.name == executableName })
            {
                _result = executable
                break
            }
        }

        guard let result = _result else { throw Error.executableNotFoundFor(executableName: executableName) }

        return result
    }
}
