import Arguments
import Foundation
import SourceryAutoProtocols
import Terminal
import ZFile

public protocol TestOptionsProtocol: ArgumentExecutableProtocol
{
    // sourcery:inline:TestOptions.AutoGenerateProtocol
    var scheme: String { get }
    var project: String { get }
    var destination: DestinationProtocol { get }
    var resultBundlePath: String { get }
    var derivedDataPath: FolderProtocol? { get }

    func arguments() throws -> Arguments
    func executableFile() throws -> FileProtocol
    // sourcery:end
}

/// Options for xcodebuild's build & test actions:
public struct TestOptions: TestOptionsProtocol, AutoGenerateProtocol
{
    public let scheme: String // -scheme
    public let project: String // -project [sub-type: path]
    public let destination: DestinationProtocol // -destination
    public let resultBundlePath: String // -resultBundlePath
    public let derivedDataPath: FolderProtocol?

    private let executableProvider: SystemProtocol

    public init(
        scheme: String,
        project: String,
        destination: Destination,
        resultBundlePath: String,
        fileSystem: FileSystem = FileSystem(),
        derivedDataPath: FolderProtocol?,
        executableProvider: SystemProtocol = System.shared
    ) throws
    {
        guard fileSystem.itemKind(at: resultBundlePath) == nil else
        {
            throw "🛣🔥 \(#line) \(#function) resultBundlePath should not exist at given path \(resultBundlePath)."
        }

        self.scheme = scheme
        self.project = project
        self.destination = destination
        self.resultBundlePath = resultBundlePath
        self.derivedDataPath = derivedDataPath
        self.executableProvider = executableProvider
    }

    public func arguments() throws -> Arguments
    {
        var args = Arguments([])

        args += _option("scheme", value: scheme)
        args += _option("project", value: project)
        args += _option("destination", value: destination.asString)
        args += _option("resultBundlePath", value: resultBundlePath)
        args += _option("derivedDataPath", value: derivedDataPath?.path)

        args.append(["-quiet", "test"]) // arguments without a value

        return args
    }

    public func executableFile() throws -> FileProtocol
    {
        return try executableProvider.executable(with: "") // TODO: this is not yet used.
    }
}
