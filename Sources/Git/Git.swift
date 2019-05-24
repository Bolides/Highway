import Foundation
import SourceryAutoProtocols
import Url
import ZFile

public protocol GitToolProtocol: AutoMockable
{
    // sourcery:inline:GitTool.AutoGenerateProtocol

    func isClean() throws -> Bool
    func status() throws -> [String]
    func addAll() throws -> [String]
    func commit(message: String) throws -> [String]
    func pushToMaster() throws -> [String]
    func pushTagsToMaster() throws -> [String]
    func pull() throws -> [String]
    func currentTag() throws -> [String]
    func clone(with options: CloneOptions) throws -> [String]
    // sourcery:end
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
