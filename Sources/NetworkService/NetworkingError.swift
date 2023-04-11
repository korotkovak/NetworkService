//
//  NetworkingError.swift
//  MarvelComicsAlamofire
//
//  Created by Kristina Korotkova on 08/03/23.
//

import Foundation

public enum NetworkingError: String, Error {
    case invalidPath = "Invalid Path"
    case decoding = "There was an error decoding the type"
    case invalidParameters = "Invalid Parameters"
    case invalidData = "Invalid Data"
    case unknownError = "Unknown error"
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(rawValue, comment: "")
    }
}
