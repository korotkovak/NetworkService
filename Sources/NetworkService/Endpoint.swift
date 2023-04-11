//
//  Endpoint.swift
//  MarvelComicsAlamofire
//
//  Created by Nikita Kazakov on 02.04.2023.
//

import Foundation

/// This protocol configures the endpoint for your API.
/// The protocol includes: path, method, header, parameters.
public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var parameters: [String: Any] { get }
}

public extension Endpoint {
    var header: [String: String] {
        [:]
    }

    var parameters: [String: Any] {
        [:]
    }
}
