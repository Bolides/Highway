//
//  DemoSourceryWorker.swift
//  Automate
//
//  Created by Stijn on 16/12/2018.
//  Copyright © 2018 dooz. All rights reserved.
//

import Arguments
import Errors
import Foundation
import HighwayDispatch
import SignPost
import SourceryAutoProtocols
import SourceryWorker
import SwiftFormatWorker
import Terminal
import ZFile

public protocol HWSetupSourceryWorkerWorkerProtocol: AutoMockable
{
    // sourcery:inline:HWSetupSourceryWorker.AutoGenerateProtocol

    func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) throws

    // sourcery:end
}

public class HWSetupSourceryWorker: HWSetupSourceryWorkerWorkerProtocol, AutoGenerateProtocol
{
    // sourcery:skipProtocol
    public static let queue = DispatchQueue(label: "be.dooz.swiftformatWorker.sourceryWorker")

    // MARK: - Private

    private let signPost: SignPostProtocol
    private let workers: [SourceryWorkerProtocol]

    private let queue: DispatchQueue

    private let dispatchGroup: HWDispatchGroupProtocol

    // MARK: - Init

    public init(
        swiftPackageDependencies: DependencyProtocol,
        sourceryBuilder: SourceryBuilderProtocol,
        dispatchGroup: HWDispatchGroupProtocol,
        swiftPackageDump: DumpProtocol,
        signPost: SignPostProtocol = SignPost.shared,
        queue: DispatchQueue = HWSetupSourceryWorker.queue
    ) throws
    {
        self.signPost = signPost
        self.queue = queue
        self.dispatchGroup = dispatchGroup

        do
        {
            let sourcerySequence: [Sourcery] = try swiftPackageDump.products.compactMap
            { product in

                guard !product.name.hasSuffix("Mock") else
                {
                    return nil
                }

                guard let hwProduct = HighwayProduct(rawValue: product.name) else
                {
                    let location = "\(HWSetupSourceryWorker.self) \(#function) \(#line)"
                    let error = """
                    \(product.name) is not a valid product name
                    ℹ️ add it as a case to \(HighwayProduct.self) enum
                    """
                    throw HighwayError.highwayError(atLocation: location, error: error)
                }

                return try Sourcery(productName: hwProduct.rawValue, swiftPackageDependencies: swiftPackageDependencies, swiftPackageDump: swiftPackageDump, sourceryBuilder: sourceryBuilder)
            }

            workers = sourcerySequence.map { SourceryWorker(sourcery: $0, queue: HWSetupSourceryWorker.queue) }
        }
        catch
        {
            throw HighwayError.highwayError(atLocation: "\(HWSetupSourceryWorker.self) \(#function) \(#line)", error: error)
        }
    }

    // MARK: - Error

    // MARK: - Sourcery Setup

    public func attempt(_ async: @escaping (@escaping SourceryWorker.SyncOutput) -> Void) throws
    {
        try workers.forEach
        { [weak self] in
            guard let `self` = self else
            {
                throw HighwayError.prematureRelease(in: "\(HWSetupSourceryWorker.self) \(#function) \(#line)")
            }
            self.dispatchGroup.enter()
            $0.attempt(in: try $0.sourceryYMLFile.parentFolder())
            { [weak self] syncOutput in

                async
                {
                    let output = try syncOutput()
                    self?.signPost.verbose("\(output.joined(separator: "\n"))")
                    return output
                }
            }
        }
    }
}
