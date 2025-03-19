//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

protocol Endpoint {
    var url: String { get }
}

struct TrendingMoviesEndpoint: Endpoint {
    var url: String { MConstants.base + "/3/trending/movie/week" }
}

struct DiscoverMoviesEndpoint: Endpoint {
    var url: String { MConstants.base + "/3/discover/movie" }
}

struct MovieDetailsEndpoint: Endpoint {
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var url: String { MConstants.base + "/3/movie/\(id)" }
}

struct MovieImagesEndpoint: Endpoint {
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var url: String { MConstants.base + "/3/movie/\(id)/images" }
}

struct CustomEndpoint: Endpoint {
    private var customUrl: String
    
    init(customUrl: String) {
        self.customUrl = customUrl
    }
    
    var url: String { customUrl }
}
