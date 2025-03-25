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
    
    @Published var movieVideo: MovieVideo? = nil
    @Published var movieDetails: MovieDetails? = nil
    @Published var movieImages: MovieImagesResponse? = nil
    @Published var error: Error?
    @Published var isLoading = false
    
    @Injected var movieService: MoviesNetworkingService!
    @Injected var errorHandler: MErrorHandler!
    
    func fetchMovieDetails() async throws -> MovieDetails {
        try await movieService.fetchData(api: APIConstructorImpl(endpoint: MovieDetailsEndpoint(id: movie.id))).decode()
    }
    
    func fetchMovieVideos() async throws -> MovieVideosResponse {
        try await movieService.fetchData(api: APIConstructorImpl(endpoint: MovieVideosEndpoint(id: movie.id))).decode()
    }
    
    func fetchData() async {
        isLoading = true
        
        async let details = fetchMovieDetails()
        async let videos = fetchMovieVideos()
        
        do {
            let (details, videos) = await (try details, try videos)
            movieDetails = details
            movieVideo = videos.results.first { $0.site == "YouTube" }
            isLoading = false
        } catch {
            errorHandler.process(error)
            self.error = error
            isLoading = false
        }
    }
}
