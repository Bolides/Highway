//
//  HandeErrorsFunctions.swift
//  Errors
//
//  Created by Stijn Willems on 18/03/2019.
//

import Foundation
import SignPost
import SourceryWorker

public func handleSourceryOutput(_ output: @escaping SourceryWorker.SyncOutput) { do { _ = try output() } catch { SignPost.shared.error("\(error)") } }
public func handleTestOutput(_ output: @escaping HighwayRunner.SyncTestOutput) { do { _ = try output() } catch { SignPost.shared.error("\(error)") } }
public func handleSwiftformat(_ output: @escaping HighwayRunner.SyncSwiftformat) { do { try output() } catch { SignPost.shared.error("\(error)") } }
public func handleSwiftPackageGenerateXcodeProject(_ output: @escaping HighwayRunner.SyncSwiftPackageGenerateXcodeProj) { do { SignPost.shared.verbose(try output().joined(separator: "\n")) } catch { SignPost.shared.error("\(error)") } }
