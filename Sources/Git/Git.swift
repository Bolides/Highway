import Foundation
import SourceryAutoProtocols
import Url
import ZFile

/// Git namespace

public protocol GitToolProtocol: AutoMockable
{
    // highway:inline:GitTool.AutoGenerateProtocol

    func addAll() throws
    func commit(message: String) throws
    func pushToMaster() throws
    func pushTagsToMaster() throws
    func pull() throws
    func currentTag() throws -> [String]
    func clone(with options: CloneOptions) throws -> [String]
    // highway:end
}

public struct CloneOptions: AutoMockable
{
    // MARK: - Properties

    public let remoteUrl: String
    public let localPath: FolderProtocol
    public let performMirror: Bool

    // MARK: - Init

    public init(remoteUrl: String, localPath: FolderProtocol, performMirror: Bool = false)
    {
        self.remoteUrl = remoteUrl
        self.localPath = localPath
        self.performMirror = performMirror
    }
}
