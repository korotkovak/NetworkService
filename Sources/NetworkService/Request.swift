//
//  Request.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 02.04.2023.
//

import Foundation

/// This enum configures the HTTPMethod.
/// The protocol includes: get, post, put, delete.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Request {
    var endpoint: Endpoint { get }
    func decode<T: Decodable>(type: T.Type, data: Data) throws -> T
}

public extension Request {
    func decode<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }
}
