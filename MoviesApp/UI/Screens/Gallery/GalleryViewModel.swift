//
//  GalleryViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import Combine

class GalleryViewModel: ObservableObject {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    @Published var movieImages: MovieImagesResponse? = nil
    @Published var isLoaded = false
    
    @Injected var movieService: MoviesNetworkingService!
    @Injected var errorHandler: MErrorHandler!
    
    func fetchMovieImages() async {
        do {
            movieImages = try await movieService.fetchData(api: APIConstructor(endpoint: .movieImages(movie.id))).decode()
            isLoaded = true
        } catch {
            errorHandler.process(error)
        }
    }
}
