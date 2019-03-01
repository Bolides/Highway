import Arguments
import Foundation
import Result
import SourceryAutoProtocols
import Task
import Terminal
import Url
import ZFile
import Errors
import SignPost

public protocol XCBuildProtocol: AutoMockable
{
    /// sourcery:inline:XCBuild.AutoGenerateProtocol
    var system: SystemProtocol { get }
    var fileSystem: FileSystemProtocol { get }
    var terminalWorker: TerminalWorkerProtocol { get }

    func archive(using options: ArchiveOptionsProtocol) throws  -> ArchiveProtocol
    func export(using options: ExportArchiveOptionsProtocol) throws  -> ExportProtocol
    func buildAndTest(using options: ArgumentExecutableProtocol) throws  -> TestReportProtocol
    func findPosibleDestinations(for scheme: String, in workspace: FolderProtocol) throws -> [String]
    /// sourcery:end
}

/// Low-level Wrapper around xcodebuild. This is a starting point for additonal wrappers that do things like auto detection
/// of certain settings/options. However there are some things XCBuild already does which makes it a little bit more than
/// just a wrapper. It offers a nice struct around the export-plist, it interprets the results of executed commands
/// and finds generated files (ipas, ...). xcrun is also used throughout this class.
public final class XCBuild: XCBuildProtocol, AutoGenerateProtocol
{
    // MARK: - Properties

    public let system: SystemProtocol
    public let fileSystem: FileSystemProtocol
    public let terminalWorker: TerminalWorkerProtocol

    private let signPost: SignPostProtocol
    // MARK: - Init

    public init(
        system: SystemProtocol,
        terminalWorker: TerminalWorkerProtocol = TerminalWorker.shared,
        fileSystem: FileSystemProtocol = FileSystem.shared,
        signPost: SignPostProtocol = SignPost.shared
    )
    {
        self.system = system
        self.fileSystem = fileSystem
        self.terminalWorker = terminalWorker
        self.signPost = signPost
    }
    
    // MARK: - Find destinations
    
    public func findPosibleDestinations(for scheme: String, in workspace: FolderProtocol) throws -> [String] {
        
        do
        {
            let task = try _xcodebuild()
            var args = Arguments([])
            args += _option("scheme", value: scheme)
            args += _option("workspace", value: workspace.path)
            
            args.append("-showdestinations")
            
            task.arguments = args
            
            signPost.verbose("\(self) \(#function) started \(task)")
            let output = try terminalWorker.runProcess(task.toProcess)
            signPost.verbose("destions found \(output)")
            return output
        }
        catch
        {
            throw "\(self) \(#function) \(error)"
        }
        
    }

    // MARK: - Archiving

    @discardableResult
    public func archive(using options: ArchiveOptionsProtocol) throws -> ArchiveProtocol
    {
        _ = try system.execute(try _archiveTask(using: options))

        return try Archive(archiveFolder: try Folder(path: options.archivePath), fileSystem: fileSystem)
    }

    private func _archiveTask(using options: ArchiveOptionsProtocol) throws -> Task
    {
        let result = try _xcodebuild()
        result.arguments += options.arguments
        return result
    }

    // MARK: Exporting

    @discardableResult
    public func export(using options: ExportArchiveOptionsProtocol) throws -> ExportProtocol
    {
        let task = try _exportTask(using: options)
        guard try system.execute(task) else
        {
            throw "Export failed. No archivePath set."
        }
        return try Export(folder: try Folder(path: options.exportPath), fileSystem: fileSystem)
    }

    private func _exportTask(using options: ExportArchiveOptionsProtocol) throws -> Task
    {
        let result = try _xcodebuild()
        result.arguments += options.arguments

        return result
    }

    // MARK: Testing

    public enum TestRunError: Swift.Error
    {
        case testsFailed(report: TestReportProtocol)
    }

    @discardableResult
    public func buildAndTest(using options: ArgumentExecutableProtocol) throws -> TestReportProtocol
    {
        let xcbuild = try _buildTestTask(using: options)

        do
        {
            let output = try terminalWorker.runProcess(xcbuild.toProcess)
            return TestReport(output: output)
        }
        catch let Terminal.TerminalWorker.Error.unknownTask(errorOutput: errorOutput)
        {
            let report = TestReport(output: errorOutput)
            throw TestRunError.testsFailed(report: report)
        }
    }

    private func _buildTestTask(using options: ArgumentExecutableProtocol) throws -> Task
    {
        let result = try _xcodebuild()
        result.arguments += try options.arguments()
        return result
    }

    // MARK: Helper

    private func _xcodebuild() throws -> Task
    {
        let result = try system.task(named: "xcodebuild")
        return result
    }
}

public struct XCodeBuildOption
{
    public init(name: String, value: String?)
    {
        self.name = name
        self.value = value
    }

    fileprivate let name: String
    fileprivate var value: String?
}

extension XCodeBuildOption: ArgumentsConvertible
{
    public func arguments() -> Arguments?
    {
        guard let value = value else { return nil }
        return Arguments(["-" + name, value])
    }
}

func _option(_ name: String, value: String?) -> XCodeBuildOption
{
    return XCodeBuildOption(name: name, value: value)
}

private extension ArchiveOptionsProtocol
{
    // sourcery:skipProtocol
    var arguments: Arguments
    {
        var args = Arguments([])
        args += _option("scheme", value: scheme)
        args += _option("project", value: project)
        args += _option("destination", value: destination.asString)
        args += _option("archivePath", value: archivePath)
        args.append("archive")
        return args
    }
}

private extension ExportArchiveOptionsProtocol
{
    // sourcery:skipProtocol
    var arguments: Arguments
    {
        let exportOptionsPlistPath = "\(exportPath)/generated.plist"
        var args = Arguments(["-exportArchive"])
        args += _option("exportOptionsPlist", value: exportOptionsPlistPath)
        args += _option("archivePath", value: archivePath.path)
        args += _option("exportPath", value: exportPath)

        return args
    }
}
