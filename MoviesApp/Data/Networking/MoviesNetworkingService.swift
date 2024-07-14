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

actor MoviesNetworkingService {
    func fetchData<T: Decodable>(api: APIConstructor) async throws -> T {
        let url = try DefaultURLBuilder.build(for: api.endpoint, params: api.queryParams)
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw MoviesNetworkingServiceError.invalidStatusCode
        }
        let parsedData = try JSONDecoder().decode(T.self, from: data)
        return parsedData
    }
    
    func downloadImage(urlString: String) async -> UIImage? {
        guard !urlString.trim().isEmpty,
              let imageURL = URL(string: urlString.trim()) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: imageURL)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                return nil
            }
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
