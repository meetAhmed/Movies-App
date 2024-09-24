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

public class DeveloperPreview {
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

/*
 
 {
       "backdrop_path": "/tncbMvfV0V07UZozXdBEq4Wu9HH.jpg",
       "id": 573435,
       "title": "Bad Boys: Ride or Die",
       "original_title": "Bad Boys: Ride or Die",
       "overview": "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
       "poster_path": "/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg",
       "media_type": "movie",
       "adult": false,
       "original_language": "en",
       "genre_ids": [28, 80, 53, 35, 10749],
       "popularity": 4352.387,
       "release_date": "2024-06-05",
       "video": false,
       "vote_average": 7.463,
       "vote_count": 823
     },
 
 {
   "adult": false,
   "backdrop_path": "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg",
   "belongs_to_collection": {
     "id": 1022790,
     "name": "Inside Out Collection",
     "poster_path": "/Apr19lGxP7gm6y2HQX0kqOXTtqC.jpg",
     "backdrop_path": "/7U2m2dMSIfHx2gWXKq78Xj1weuH.jpg"
   },
   "budget": 200000000,
   "genres": [
     {
       "id": 16,
       "name": "Animation"
     },
     {
       "id": 10751,
       "name": "Family"
     },
     {
       "id": 12,
       "name": "Adventure"
     },
     {
       "id": 35,
       "name": "Comedy"
     }
   ],
   "homepage": "https://movies.disney.com/inside-out-2",
   "id": 1022789,
   "imdb_id": "tt22022452",
   "origin_country": [
     "US"
   ],
   "original_language": "en",
   "original_title": "Inside Out 2",
   "overview": "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
   "popularity": 4645.667,
   "poster_path": "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
   "production_companies": [
     {
       "id": 2,
       "logo_path": "/wdrCwmRnLFJhEoH8GSfymY85KHT.png",
       "name": "Walt Disney Pictures",
       "origin_country": "US"
     },
     {
       "id": 3,
       "logo_path": "/1TjvGVDMYsj6JBxOAkUHpPEwLf7.png",
       "name": "Pixar",
       "origin_country": "US"
     }
   ],
   "production_countries": [
     {
       "iso_3166_1": "US",
       "name": "United States of America"
     }
   ],
   "release_date": "2024-06-11",
   "revenue": 1443875604,
   "runtime": 97,
   "spoken_languages": [
     {
       "english_name": "English",
       "iso_639_1": "en",
       "name": "English"
     }
   ],
   "status": "Released",
   "tagline": "Make room for new emotions.",
   "title": "Inside Out 2",
   "video": false,
   "vote_average": 7.648,
   "vote_count": 2054
 }
 
 */
