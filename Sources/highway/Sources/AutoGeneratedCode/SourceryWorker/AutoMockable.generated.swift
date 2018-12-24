import os
import SourceryWorker
import SourceryAutoProtocols
import ZFile
import Foundation


// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

















// MARK: - ImportProtocolMock

open class ImportProtocolMock: ImportProtocol {

    public init() {}

  public  var name: String {
      get { return underlyingName }
      set(value) { underlyingName = value }
  }
  public  var underlyingName: String = "AutoMockable filled value"
  public  var testable: Bool {
      get { return underlyingTestable }
      set(value) { underlyingTestable = value }
  }
  public  var underlyingTestable: Bool = false

}


// MARK: - SourceryExecutableFileProtocolMock

open class SourceryExecutableFileProtocolMock: SourceryExecutableFileProtocol {

    public init() {}


}


// MARK: - SourceryFolderWorkerProtocolMock

open class SourceryFolderWorkerProtocolMock: SourceryFolderWorkerProtocol {

    public init() {}

  public  var scrRoot: (folder: FolderProtocol, key: SourceryFolderWorker.Key) {
      get { return underlyingScrRoot }
      set(value) { underlyingScrRoot = value }
  }
  public  var underlyingScrRoot: (folder: FolderProtocol, key: SourceryFolderWorker.Key)!


  // MARK: - <init> - parameters

  public var initBundleThrowableError: Error?
  public var initBundleReceivedBundle: BundleProtocol?

  // MARK: - <init> - closure mocks

  public var initBundleClosure: ((BundleProtocol) throws  -> Void)? = nil


  // MARK: - <init> - initializer mocked

  public required init(bundle: BundleProtocol) throws {
      initBundleReceivedBundle = bundle
     try? initBundleClosure?(bundle)
  }

}


// MARK: - TemplatePrependProtocolMock

open class TemplatePrependProtocolMock: TemplatePrependProtocol {

    public init() {}

  public  var names: Set<TemplatePrepend.Import> {
      get { return underlyingNames }
      set(value) { underlyingNames = value }
  }
  public  var underlyingNames: Set<TemplatePrepend.Import>!
  public  var template: String {
      get { return underlyingTemplate }
      set(value) { underlyingTemplate = value }
  }
  public  var underlyingTemplate: String = "AutoMockable filled value"

}


// MARK: - OBJECTIVE-C

