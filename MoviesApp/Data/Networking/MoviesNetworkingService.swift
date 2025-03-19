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
    private var urlSession: URLSession
    private var urlCache: URLCache
    
    init(urlSession: URLSession, urlCache: URLCache) {
        self.urlSession = urlSession
        self.urlCache = urlCache
    }
    
    func fetchData(api: APIConstructor) async throws -> Data {
        let url = try DefaultURLBuilder.build(for: api.endpoint, params: api.queryParams)
        let urlRequest = URLRequest(url: url, cachePolicy: api.cachePolicy)
        
        if let cacheResponse = urlCache.cachedResponse(for: urlRequest) {
            print("MoviesNetworkingService: url: \(url) cache: \(cacheResponse.data)")
        }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw MoviesNetworkingServiceError.invalidStatusCode
        }
        return data
    }
}
