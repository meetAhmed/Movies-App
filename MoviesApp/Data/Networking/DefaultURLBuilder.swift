//
//  DefaultURLBuilder.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

enum URLBuilderError: Error {
    case invalidFullPath, invalidURL
}

enum DefaultURLBuilder {
    // MARK: Default query params
    private static var defaultQueryParams = ["api_key": Build.API_KEY]
    
    static func build(for endpoint: Endpoint, params: [String: String] = [:]) throws -> URL {
        guard var urlComponents = URLComponents(string: endpoint.path) else {
            throw URLBuilderError.invalidFullPath
        }
        
        urlComponents.queryItems = buildQueryItems(defaultQueryParams, params)
        
        guard let url = urlComponents.url else {
            throw URLBuilderError.invalidURL
        }
        
        return url
    }
}

private extension DefaultURLBuilder {
    static func buildQueryItems(_ params: [String: String]...) -> [URLQueryItem] {
        params.flatMap { $0 }.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
