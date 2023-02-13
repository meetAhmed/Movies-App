//
//  GenreModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

struct Genre: Decodable, Identifiable, Equatable {
    var id: Int
    var name: String
}

struct GenreApiResponse: Decodable {
    var genres: [Genre]
}
