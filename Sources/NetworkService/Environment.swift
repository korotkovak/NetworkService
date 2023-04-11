//
//  Environment.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 14/03/23.
//

import Foundation

//public class Environment {
//    static public var scheme = "https"
//    static public var host = "gateway.marvel.com"
//
//    static var baseURL: String {
//        "\(Environment.scheme)://\(Environment.host)"
//    }
//}

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
