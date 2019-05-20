import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Url
import ZFile

/// Maps names command line tools/executables to file urls.
public protocol SystemProtocol: AutoMockable
{
    // sourcery:inline:System.AutoGenerateProtocol
    static var shared: SystemProtocol { get }
    var pathEnvironmentParser: PathEnvironmentParserProtocol { get }
    var fileSystem: FileSystemProtocol { get }

    func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func process(_ executableName: String) throws -> ProcessProtocol
    func process(currentFolder: FolderProtocol, executablePath: String) throws -> ProcessProtocol
    func process(currentFolder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol
    func executable(with executableName: String) throws -> FileProtocol

    // sourcery:end
}

public struct System: SystemProtocol, AutoGenerateProtocol
{
    public static let shared: SystemProtocol = System()

    // MARK: - Properties

    public let pathEnvironmentParser: PathEnvironmentParserProtocol
    public let fileSystem: FileSystemProtocol

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let terminal: TerminalProtocol

    // MARK: - Init

    public init(
        pathEnvironmentParser: PathEnvironmentParserProtocol = PathEnvironmentParser.shared,
        fileSystem: FileSystemProtocol = FileSystem.shared,
        signPost: SignPostProtocol = SignPost.shared,
        terminal: TerminalProtocol = Terminal.shared
    )
    {
        self.pathEnvironmentParser = pathEnvironmentParser
        self.fileSystem = fileSystem
        self.signPost = signPost
        self.terminal = terminal
    }

    // MARK: - Brew support

    /// Will use `/usr/local/bin/brew` to find the executable file to setup the Process
    public func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            let gitSecretName = "git-secret"
            let brewPath = "/usr/local/bin/brew"

            let brewList = try process(currentFolder: folder, executablePath: brewPath)
            brewList.arguments = ["list", gitSecretName]

            var _output: String?
            _output = try terminal.runProcess(brewList).first { $0.hasSuffix(gitSecretName) }

            if _output == nil
            {
                signPost.error("\(pretty_function()) missing \(gitSecretName)")
                signPost.message("install with `brew install \(gitSecretName)`")

                let brewinstall = try process(currentFolder: folder, executablePath: brewPath)
                brewinstall.arguments = ["install", gitSecretName]

                try terminal.runProcess(brewinstall)
                _output = try terminal.runProcess(brewList).first { $0.hasSuffix(gitSecretName) }
            }

            guard let output = _output else
            {
                throw HighwayError.highwayError(atLocation: pretty_function(), error: "unable to find or install \(gitSecretName)")
            }

            return try process(currentFolder: folder, executableFile: try File(path: output))
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Public functions

    public func process(_ executableName: String) throws -> ProcessProtocol
    {
        return try Task(commandName: executableName, fileSystem: fileSystem, provider: self, signPost: signPost).toProcess
    }

    public func process(currentFolder: FolderProtocol, executablePath: String) throws -> ProcessProtocol
    {
        let file = try fileSystem.file(path: executablePath)
        return try process(currentFolder: currentFolder, executableFile: file)
    }

    public func process(currentFolder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol
    {
        let process = Process()
        try process.executable(set: executableFile)
        process.currentDirectoryPath = currentFolder.path

        return process
    }

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

    // MARKL: - Error

    public enum Error: Swift.Error
    {
        case executableNotFoundFor(executableName: String)
    }
}
