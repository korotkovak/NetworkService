//
//  Endpoint.swift
//  MarvelComicsAlamofire
//
//  Created by Nikita Kazakov on 02.04.2023.
//

import Foundation

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
