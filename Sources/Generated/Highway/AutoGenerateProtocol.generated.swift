// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

//: Do not change this code as it is autogenerated every time you build.
//: You can change the code in `../StencilTemplatesForSourcery/Application/AutoGenerateProtocol
import Foundation

// MARK: - AutoGenerateProtocol

//: From all Types implementing this protocol Sourcery adds:
//: - public/internal variables // private variables are ignored
//: - public/internal methods (skips initializers)
//: - initializers marked with annotation // sourcery:includeInitInProtocol
//: - of the above it does not add it if  // sourcery:skipProtocol
//: ---

/*

 // Generated protocol inline for Highway -> See code in the file of that type
 // sourcery:inline:Highway.AutoGenerateProtocol
 static var queue: HighwayDispatchProtocol { get }
 var package: (package: PackageProtocol, executable: String) { get }
 var sourceryBuilder: SourceryBuilderProtocol { get }
 var sourceryWorkers: [SourceryWorkerProtocol] { get }
 var queue: HighwayDispatchProtocol { get }
 var githooks: GitHooksWorkerProtocol? { get }
 var swiftformat: SwiftFormatWorkerProtocol { get }

 static func package(for folder: FolderProtocol, dependencyService: DependencyServiceProtocol, terminal: TerminalProtocol = Terminal.shared, signPost: SignPostProtocol = SignPost.shared) throws  -> PackageProtocol
 // sourcery:end
 // Generated protocol inline for Highway.Package -> See code in the file of that type
 // sourcery:inline:Highway.Package.AutoGenerateProtocol
 var name: String { get }
 var dependencies: DependencyProtocol { get }
 var dump: DumpProtocol { get }

 // sourcery:end
 // Generated protocol inline for HighwayRunner -> See code in the file of that type
 // sourcery:inline:HighwayRunner.AutoGenerateProtocol
 static var queue: HighwayDispatchProtocol { get }
 var errors: [Swift.Error]? { get set }
 var highway: HighwayProtocol { get }

 func runTests(_ async: @escaping (@escaping HighwayRunner.SyncTestOutput) -> Void)
 func runSourcery(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void)
 func addGithooksPrePush() throws
 func runSwiftformat(_ async: @escaping (@escaping HighwayRunner.SyncSwiftformat) -> Void)
 func runSwiftPackageGenerateXcodeProject(_ async: @escaping (@escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) -> Void)
 // sourcery:end
 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 // Generated protocol inline for  -> See code in the file of that type

 */
