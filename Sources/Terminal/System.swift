import Errors
import Foundation
import SignPost
import SourceryAutoProtocols
import Url
import ZFile

/**
 Maps names command line tools/executables to file urls.
*/
public protocol SystemProtocol: AutoMockable
{
    // sourcery:inline:System.AutoGenerateProtocol
    static var shared: SystemProtocol { get }
    static var brewPath: String { get set }
    static var jazzyPath: String { get set }
    var pathEnvironmentParser: PathEnvironmentParserProtocol { get }
    var fileSystem: FileSystemProtocol { get }

    func rbenvProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    func gemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func rbenvWhichProcess(gemName: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func installOrFindGemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func installOrGetProcessFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    // sourcery:Will throw error if the formula is not installed when you run this process
    func brewListProcess(for formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    func process(_ executableName: String) throws -> ProcessProtocol
    func process(currentFolder: FolderProtocol, executablePath: String) throws -> ProcessProtocol
    func process(currentFolder: FolderProtocol, executableFile: FileProtocol) throws -> ProcessProtocol
    func executable(with executableName: String) throws -> FileProtocol

    // sourcery:end
}

public struct System: SystemProtocol, AutoGenerateProtocol
{
    public static let shared: SystemProtocol = System()
    public static var brewPath = "/usr/local/bin/brew"
    /// will be overridden if different for this session
    public static var jazzyPath = "/usr/local/bin/jazzy"

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

    // MARK: - Ruby and gem support

    /**
         Will install rbenv with xcode if needed
     */
    public func rbenvProcess(in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            return try installOrGetProcessFromBrew(formula: "rbenv", in: folder)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    /**
         Looks up the gem and makes int a process
         Throws `System.Error.gemListNoGem(name:)` if gem is not found
     */
    public func gemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            signPost.verbose("\(pretty_function()) gem \(name) lookup ...")

            guard fileSystem.file(possbilyInvalidPath: System.jazzyPath) == nil else
            {
                let jazzyExecutable = try fileSystem.file(path: System.jazzyPath)
                let result = try process(currentFolder: folder, executableFile: jazzyExecutable)

                signPost.verbose("\(pretty_function()) gem \(name) lookup ✅")

                return result
            }

            let gemName = "gem"
            let rbenv = try rbenvWhichProcess(gemName: gemName, in: folder)

            guard let rbenvOutput = (try terminal.runProcess(rbenv).filter { !$0.isEmpty }.first) else
            {
                throw Error.executableNotFoundFor(executableName: gemName)
            }

            let gemList = try process(currentFolder: folder, executableFile: try File(path: rbenvOutput))
            gemList.arguments = ["list", name]

            let gemListOutput = try terminal.runProcess(gemList).first { $0.hasPrefix(name) }

            guard (gemListOutput?.count ?? 0) > 0 else
            {
                throw Error.gemListNoGem(forName: name)
            }

            let rbenvWhichJazzy = try rbenvWhichProcess(gemName: name, in: folder)

            let rbenvWhichJazzyOutput = try terminal.runProcess(rbenvWhichJazzy)

            guard let jazzyPath = (rbenvWhichJazzyOutput.first { !$0.isEmpty }) else
            {
                throw Error.executableNotFoundFor(executableName: name)
            }

            System.jazzyPath = jazzyPath

            let _process = try process(currentFolder: folder, executableFile: try File(path: jazzyPath))
            signPost.verbose("\(pretty_function()) gem \(name) lookup ✅")

            return _process
        }
        catch let error as System.Error
        {
            throw Error.error(atLocation: pretty_function(), error: error)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func rbenvWhichProcess(gemName: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        let rbenv = try installOrGetProcessFromBrew(formula: "rbenv", in: folder)
        rbenv.arguments = ["which", gemName]
        return rbenv
    }

    public func installOrFindGemProcess(name: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            return try gemProcess(name: name, in: folder)
        }
        catch let error as System.Error
        {
            guard error == System.Error.gemListNoGem(forName: name) else
            {
                throw error
            }

            let gemInstall = try installOrGetProcessFromBrew(formula: "gem", in: folder)
            gemInstall.arguments = ["install", name]

            try terminal.runProcess(gemInstall)
            return try gemProcess(name: name, in: folder)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // MARK: - Brew support

    /**
         Will use `/usr/local/bin/brew` to find the executable file to setup the Process
     */
    public func processFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            let brewList = try brewListProcess(for: formula, in: folder)

            let output = try terminal.runProcess(brewList)

            guard (output.first { $0.hasPrefix("Error") }) == nil else
            {
                throw Error.brewListNoFormula(forName: formula)
            }

            guard let executablePath = (output.first { $0.hasSuffix(formula) }) else
            {
                throw Error.executableNotFoundFor(executableName: formula)
            }

            return try process(currentFolder: folder, executableFile: try File(path: executablePath))
        }
        catch let error as System.Error
        {
            throw System.Error.error(atLocation: pretty_function(), error: error)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    public func installOrGetProcessFromBrew(formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        do
        {
            return try processFromBrew(formula: formula, in: folder)
        }
        catch var error as System.Error
        {
            error = error.indirectError == nil ? error : error.indirectError!

            guard
                error == Error.brewListNoFormula(forName: formula) else
            {
                throw System.Error.error(atLocation: pretty_function(), error: error)
            }

            signPost.error("\(pretty_function()) missing \(formula)")
            signPost.message("`brew install \(formula)` ... ")

            let brewinstall = try process(currentFolder: folder, executablePath: System.brewPath)
            brewinstall.arguments = ["install", formula]

            try terminal.runProcess(brewinstall)
            signPost.message("`brew install \(formula)` ✅")
            return try processFromBrew(formula: formula, in: folder)
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: pretty_function(), error: error)
        }
    }

    // sourcery: Will throw error if the formula is not installed when you run this process
    public func brewListProcess(for formula: String, in folder: FolderProtocol) throws -> ProcessProtocol
    {
        let brewList = try process(currentFolder: folder, executablePath: System.brewPath)
        brewList.arguments = ["list", formula]

        return brewList
    }

    // MARK: - Get processes already installed on the system

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

    public indirect enum Error: Swift.Error, Equatable
    {
        case executableNotFoundFor(executableName: String)
        case brewListNoFormula(forName: String)
        case general(String)
        case error(atLocation: String, error: System.Error)
        case gemListNoGem(forName: String)

        var indirectError: Error?
        {
            switch self
            {
            case .error(atLocation: _, error: let error):
                return error
            default:
                return nil
            }
        }
    }
}
