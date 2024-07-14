//
//  Movie.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import Foundation

struct MovieApiResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage, voteCount: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    func imageFullPath(type: MovieImageType) -> String {
        switch type {
        case .poster:
            return Endpoint.imageBaseUrl + (posterPath == nil ? backdropPath.stringValue : posterPath.stringValue)
        case .backdrop:
            return Endpoint.imageBaseUrl + (backdropPath == nil ? posterPath.stringValue : backdropPath.stringValue)
        case .any:
            return Endpoint.imageBaseUrl + (posterPath == nil ? backdropPath.stringValue : posterPath.stringValue)
        }
    }
}
