//
//  NetworkDispatcher.swift
//  MarvelComicsAlamofire
//
//  Created by Nikita Kazakov on 02.04.2023.
//

import Foundation

public protocol NetworkDispatcher {
    @available(iOS 13.0.0, *)
    func request<T: Decodable>(_ model: any Request) async throws -> T
}

public class NetworkDispatcherImpl: NetworkDispatcher {

    private weak var environment: Environment?

    public init(environment: Environment) {
        self.environment = environment
    }

    @available(iOS 13.0.0, *)
    public func request<T: Decodable>(_ model: any Request) async throws -> T {
        let baseURL = (environment?.baseURL ?? "") + model.endpoint.path
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkingError.invalidPath
        }

        switch model.endpoint.method {
        case .delete, .get:
            components.queryItems = model.endpoint.parameters
                .compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
        default: break
        }

        guard let url = components.url else { throw NetworkingError.invalidParameters }

        var request = URLRequest(url: url)
        request.httpMethod = model.endpoint.method.rawValue

        switch model.endpoint.method {
        case .post, .put:
            request.httpBody = try? JSONSerialization.data(withJSONObject: model.endpoint.parameters)
        default: break
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try model.decode(type: T.self, data: data)
    }
}
