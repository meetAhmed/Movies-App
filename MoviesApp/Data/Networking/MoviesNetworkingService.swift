//
//  MoviesNetworkingService.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import UIKit

enum MoviesNetworkingServiceError: Error {
    case invalidStatusCode
}

protocol MoviesNetworkingService {
    func fetchData(api: APIConstructor) async throws -> Data
}

class MoviesNetworkingServiceImpl: MoviesNetworkingService {
    func fetchData(api: APIConstructor) async throws -> Data {
        let url = try DefaultURLBuilder.build(for: api.endpoint, params: api.queryParams)
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw MoviesNetworkingServiceError.invalidStatusCode
        }
        return data
    }
}
