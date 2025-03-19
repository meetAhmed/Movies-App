//
//  APIConstructor.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

typealias Parameters = [String: String]

enum MHttpMethods {
    case get, post
}

protocol APIConstructor {
    var endpoint: Endpoint { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var queryParams: Parameters { get }
    var headers: Parameters { get }
    var httpMethod: MHttpMethods { get }
}

struct APIConstructorImpl: APIConstructor {
    let endpoint: Endpoint
    var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    var queryParams: Parameters = [:]
    var headers: Parameters = [:]
    var httpMethod: MHttpMethods = .get
}
