//
//  PreviewProvider.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let genre = Genre(id: 28, name: "Action")
    
    let movie = Movie(
        adult: false,
        backdropPath: "/8I37NtDffNV7AZlDa7uDvvqhovU.jpg",
        genreIDS: [28, 35],
        id: 19995,
        originalLanguage: "hi",
        originalTitle: "Bade Miyan Chote Miyan",
        overview: "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
        popularity: 1145.042,
        posterPath: "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
        releaseDate: "2009-12-15",
        title: "Avatar",
        video: false,
        voteAverage: 7.6,
        voteCount: 28031
    )
    
    let review = Review(
        author: "tomasfv",
        authorDetails: AuthorDetails(
            name: "MSB",
            username: "msbreviews",
            avatarPath: "https://www.gravatar.com/avatar/992eef352126a53d7e141bf9e8707576.jpg",
            rating: 8.0
        ),
        content: "Rewatching Avatar confirmed my love for Pandora. Exquisite world-building by James Cameron, memorable score by James Horner & jaw-dropping, innovative visuals that complement wonderful storytelling.\r\n\r\nHow can people not remember these characters?! Super excited about tomorrow's IMAX screening of Avatar: The Way of Water!",
        createdAt: "2022-12-17T09:49:43.827Z",
        id: "639d90b74f33ad008cffa3f4",
        updatedAt: "2022-12-17T09:49:43.897Z",
        url: "https://www.themoviedb.org/review/639d90b74f33ad008cffa3f4"
    )
}
