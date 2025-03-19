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
    
    @Injected var movieService: MoviesNetworkingService!
    @Injected var errorHandler: MErrorHandler!
    
    func fetchMovieDetails() async {
        isLoading = true
        do {
            movieDetails = try await movieService.fetchData(api: APIConstructorImpl(endpoint: MovieDetailsEndpoint(id: movie.id))).decode()
            isLoading = false
        } catch {
            errorHandler.process(error)
            self.error = error
            isLoading = false
        }
    }
}
