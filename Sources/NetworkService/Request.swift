//
//  Request.swift
//  MarvelComicsAlamofire
//
//  Created by Nikita Kazakov on 02.04.2023.
//

import Foundation

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
