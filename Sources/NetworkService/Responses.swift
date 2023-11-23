//
//  Responses.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 02.04.2023.
//

import Foundation

struct ObjectDataResponse<T: Codable>: Codable {
    let data: T?
}

struct PaginationList<T: Codable>: Codable {
    let results: [T]?
    let count: Int?

    let nextPage: Int?
    let prevPage: Int?
}
