//
//  JWTTokenWorker.swift
//  🛣
//
//  Created by Stijn on 28/12/2018.
//

import CupertinoJWT
import Foundation
import os
import SourceryAutoProtocols
import ZFile

public protocol JWTTokenWorkerProtocol: AutoMockable
{
    /// sourcery:inline:JWTTokenWorker.AutoGenerateProtocol
    var token: String { get }
    /// sourcery:end
}

public struct JWTTokenWorker: JWTTokenWorkerProtocol, AutoGenerateProtocol
{
    public let token: String

    public init(p8KeyFile: FileProtocol) throws
    {
        // Assign developer information and token expiration setting
        let keyID = "VV7NT37UVU"
        let teamID = "69a6de78-d037-47e3-e053-5b8c7c11a4d1"
        let issueDate = Date()
        let expireDuration: TimeInterval = 60 * 60

        let jwt = CupertinoJWT.JWT(keyID: keyID, teamID: teamID, issueDate: issueDate, expireDuration: expireDuration)

        token = try jwt.sign(with: try p8KeyFile.readAsString())
        // Use the token in the authorization header in your requests connecting to Apple’s API server.
        // e.g. urlRequest.addValue(_ value: "bearer \(token)", forHTTPHeaderField field: "authorization")
    }
}
