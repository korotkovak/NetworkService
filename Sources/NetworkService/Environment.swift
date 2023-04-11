//
//  Environment.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 14/03/23.
//

import Foundation

public class Environment {
    static public var scheme = "https"
    static public var host = "gateway.marvel.com"

    static var baseURL: String {
        "\(Environment.scheme)://\(Environment.host)"
    }
}
