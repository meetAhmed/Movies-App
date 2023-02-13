//
//  Review.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import Foundation

struct ReviewApiResponse: Decodable {
    let id, page: Int
    let results: [Review]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Review: Decodable, Identifiable {
    let author: String
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

extension Review {
    var authorName: String {
        authorDetails?.authorName ?? author
    }
    
    var authorImage: String {
        var imageUrl = authorDetails?.avatarPath ?? ""
        if imageUrl.starts(with: "/") {
            imageUrl = String(imageUrl.dropFirst())
        }
        return imageUrl
    }
}

struct AuthorDetails: Decodable {
    let name, username: String
    let avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

extension AuthorDetails {
    var authorName: String {
        name.trim().isEmpty ? username : name.trim()
    }
}
