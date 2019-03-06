import Arguments
import Foundation
import SignPost
import SourceryAutoProtocols
import ZFile
import ZFileMock


// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - ArgumentsWorkerProtocolMock

open class ArgumentsWorkerProtocolMock: ArgumentsWorkerProtocol {

    public init() {}

  public var workers: [Worker] = []

}


// MARK: - DiskProtocolMock

open class DiskProtocolMock: DiskProtocol {

    public init() {}

  public  var srcRoot: FolderProtocol {
      get { return underlyingSrcRoot }
      set(value) { underlyingSrcRoot = value }
  }
  public  var underlyingSrcRoot: FolderProtocol!
  public  var carthage: Disk.Carthage {
      get { return underlyingCarthage }
      set(value) { underlyingCarthage = value }
  }
  public  var underlyingCarthage: Disk.Carthage!

}


// MARK: - OBJECTIVE-C

