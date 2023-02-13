//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var searchedMovies: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var reviews: [Review] = []
    @Published var error: Error?
    @Published var searchedText = ""
    @Published var selected: Genre = DeveloperPreview.instance.genre
    @Published var selectedMovie: Movie?
    
    private var previousSearchTask: Task<(), Never>?
    private let movieService = MoviesNetworkingService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubcriber()
    }
    
    func fetchGenres() async {
        do {
            let response: GenreApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .genres))
            await MainActor.run(body: {
                genres = response.genres
            })
        } catch {
            await self.updateError(error)
        }
    }
    
    func fetchMovies() {
        Task.detached {
            do {
                let api = APIConstructor(endpoint: .discoverMovies, queryParams: [
                    "sort_by": "release_date.desc",
                    "with_genres": "\(self.selected.id)"
                ])
                let response: MovieApiResponse = try await self.movieService.fetchData(api: api)
                await self.updateMoviesList(response.results, .movies)
            } catch {
                await self.updateError(error)
            }
        }
    }
    
    func fetchTrending() async {
        do {
            let response: MovieApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .trending))
            await self.updateMoviesList(response.results, .trending)
        } catch {
            await self.updateError(error)
        }
    }
    
    func searchMovies(query: String) async {
        do {
            let response: MovieApiResponse = try await self.movieService.fetchData(api: APIConstructor(endpoint: .search, queryParams: ["query": query]))
            await self.updateMoviesList(response.results, .searched)
        } catch {
            await self.updateError(error)
        }
    }
    
    func fetchTopRatedMovies() async {
        do {
            let response: MovieApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .topRated))
            await self.updateMoviesList(response.results, .topRated)
        } catch {
            await self.updateError(error)
        }
    }
    
    func fetchMovieReviews() async {
        guard let movieId = selectedMovie?.id else { return }
        do {
            let response: ReviewApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .reviews(movieId)))
            await self.updateReviews(response.results)
        } catch {
            await self.updateError(error)
        }
    }
}

private extension HomeViewModel {
    func addSubcriber() {
        // MARK: Search subscriber
        $searchedText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { str in
                if !str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Task.detached {
                        await self.searchMovies(query: str)
                    }
                }
            }
            .store(in: &cancellables)
        
        // MARK: Genre subscriber
        $selected
            .sink { genre in
                self.fetchMovies()
            }
            .store(in: &cancellables)
    }
}

private extension HomeViewModel {
    @MainActor
    func updateMoviesList(_ list: [Movie], _ type: ListType) {
        switch type {
        case .movies:
            movies = list
        case .trending:
            trendingMovies = list
        case .searched:
            searchedMovies = list
        case .topRated:
            topRated = list
        }
    }
    
    @MainActor
    func updateError(_ err: Error) {
        error = err
        print("Error: \(err)")
    }
    
    @MainActor
    func updateReviews(_ list: [Review]) {
        reviews = list
    }
}

enum ListType {
    case movies, trending, searched, topRated
}
