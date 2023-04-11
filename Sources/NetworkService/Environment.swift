//
//  Environment.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 14/03/23.
//

import Foundation

/// This protocol configures the Environment for your API.
/// The protocol includes: scheme and host.
public protocol Environment {
    var scheme: String { get }
    var host: String { get }
    var baseURL: String { get }
}

public extension Environment {
    var baseURL: String {
        "\(scheme)://\(host)"
    }
}
