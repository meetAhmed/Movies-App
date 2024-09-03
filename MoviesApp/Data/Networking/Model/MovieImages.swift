//
//  MovieImages.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/07/2024.
//

import Foundation

struct MovieImagesResponse: Decodable {
    let id: Int
    let backdrops, logos, posters: [MovieImage]
}

extension MovieImagesResponse {
    var imagesToShow: [MovieImage] {
        backdrops + logos + posters
    }
}

struct MovieImage: Decodable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
    
    var urlString: String {
        Endpoint.imageBaseUrl + filePath
    }
}
