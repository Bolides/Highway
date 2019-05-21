//
//  Secret.swift
//  Highway
//
//  Created by Stijn Willems on 21/05/2019.
//

import Foundation

import SourceryAutoProtocols

public protocol SecretProtocol: AutoMockable
{
    // sourcery:inline:Secret.AutoGenerateProtocol
    var gpgPassphrase: String { get }
    // sourcery:end
}

public struct Secret: Codable, SecretProtocol, AutoGenerateProtocol
{
    public let gpgPassphrase: String
}
