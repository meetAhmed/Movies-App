//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/07/2024.
//

import Combine

@MainActor
class DetailViewModel: ObservableObject {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    @Published var movieDetails: MovieDetails? = nil
    @Published var movieImages: MovieImagesResponse? = nil
    @Published var error: Error?
    @Published var isLoading = false
    
    private let movieService = MoviesNetworkingService()
    
    func fetchMovieDetails() async {
        isLoading = true
        do {
            movieDetails = try await movieService.fetchData(api: APIConstructor(endpoint: .movieDetails(movie.id)))
            isLoading = false
        } catch {
            print(error)
            self.error = error
            isLoading = false
        }
    }
    
    func fetchMovieImages() async {
        isLoading = true
        do {
            movieImages = try await movieService.fetchData(api: APIConstructor(endpoint: .movieImages(movie.id)))
            isLoading = false
        } catch {
            print(error)
            self.error = error
            isLoading = false
        }
    }
}
