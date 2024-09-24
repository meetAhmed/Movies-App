//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

enum Endpoint {
    case trending
    case discoverMovies
    case genres
    case search
    case topRated
    case reviews(_ movieId: Int)
    case movieDetails(_ movieId: Int)
    case movieImages(_ movieId: Int)
    case custom(_ url: String)
}

extension Endpoint {
    static var imageBaseUrl: String {
        "https://image.tmdb.org/t/p/original"
    }
    
    static var widgetImageBaseUrl: String {
        "https://image.tmdb.org/t/p/w300"
    }
}

extension Endpoint {
    var base: String {
        "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .trending:
            return base + "/3/trending/movie/week"
        case .discoverMovies:
            return base + "/3/discover/movie"
        case .genres:
            return base + "/3/genre/movie/list"
        case .search:
            return base + "/3/search/movie"
        case .topRated:
            return base + "/3/movie/top_rated"
        case .reviews(let movieId):
            return base + "/3/movie/\(movieId)/reviews"
        case .movieDetails(let movieId):
            return base + "/3/movie/\(movieId)"
        case .movieImages(let movieId):
            return base + "/3/movie/\(movieId)/images"
        case .custom(let url):
            return url
        }
    }
}
