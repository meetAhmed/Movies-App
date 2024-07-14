//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
//    @Namespace var namespace
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                //                titleView
                
                //                SearchBar(searchedText: $viewModel.searchedText)
                
                //                if viewModel.searchedText.isEmpty {
                //                    trendingView
                //
                //                    topRated
                //
                //                    genreView
                //                } else {
                //                    searchedList
                //                }
//                if let movie = viewModel.topMovie {
//
//                }
                
                TopMovieView(movie: viewModel.topMovie)
                
                top10Section
                
                previewsSection
                
                continueWatchingSection
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(.black)
        .environment(\.colorScheme, .dark)
        //        .fullScreenCover(item: $viewModel.selectedMovie) { movie in
        //            DetailView(movie: movie)
        //        }
        .task {
            await viewModel.fetchTrending()
            //            async let fetchMovies: Void =
            //            async let fetchGenres: Void = viewModel.fetchGenres()
            //            async let fetchTrending: Void = viewModel.fetchTrending()
            //            async let fetchTopRatedMovies: Void = viewModel.fetchTopRatedMovies()
            //            _ = await [fetchMovies, fetchGenres, fetchTrending, fetchTopRatedMovies]
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}

private extension HomeView {
    //    var titleView: some View  {
    //        Text("What do you want to watch?")
    //            .poppins(.medium, 18)
    //            .frame(maxWidth: .infinity, alignment: .leading)
    //    }
    
    var previewsSection: some View {
        VStack(spacing: 4) {
            MovieTitleView("Your Next Watch")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.trendingMovies.shuffled()) { movie in
                        PreviewCardView(movie: movie)
                    }
                }
            }
        }
        .padding()
        .redacted(reason: viewModel.isLoadingTrendingMovies ? .placeholder : [])
    }

    var continueWatchingSection: some View {
        VStack(spacing: 4) {
            MovieTitleView("Continue Watching for Ahmed Ali")
                
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(viewModel.trendingMovies.shuffled()) { movie in
                        ContinueWatchingCardView(movie: movie)
                    }
                }
            }
        }
        .padding()
        .redacted(reason: viewModel.isLoadingTrendingMovies ? .placeholder : [])
    }
    
    var top10Section: some View {
        VStack(spacing: 4) {
            MovieTitleView("Top 10 Movies in Pakistan Today")
                
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<(viewModel.trendingMovies.count > 10 ? 10 : viewModel.trendingMovies.count), id: \.self) { index in
                        Top10CardView(count: index + 1, movie: viewModel.trendingMovies[index])
                    }
                }
            }
        }
        .padding()
        .redacted(reason: viewModel.isLoadingTrendingMovies ? .placeholder : [])
    }

    //    var trendingView: some View {
    //        VStack {
    //            Text("Trending Now")
    //                .poppins(.medium, 18)
    //                .hAlign(.leading)
    //                .padding(.top, 10)
    //
    //            ScrollView(.horizontal, showsIndicators: false) {
    //                LazyHStack(spacing: 20) {
    //                    ForEach(viewModel.trendingMovies) { movie in
    //                        MovieCard(movie: movie)
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    //    var topRated: some View {
    //        VStack {
    //            Text("Top Rated")
    //                .poppins(.medium, 18)
    //                .hAlign(.leading)
    //                .padding(.top, 10)
    //
    //            ScrollView(.horizontal, showsIndicators: false) {
    //                LazyHStack(spacing: 20) {
    //                    ForEach(viewModel.topRated) { movie in
    //                        MovieCard(movie: movie, type: .topRated)
    //                    }
    //                }
    //            }
    //        }
    //    }
    //
    //    var genreView: some View {
    //        VStack(spacing: 10) {
    //            ScrollView(.horizontal, showsIndicators: false) {
    //                LazyHStack {
    //                    ForEach(viewModel.genres) { genre in
    //                        GenreCard(genre: genre, selected: $viewModel.selected, namespace: namespace)
    //                    }
    //                }
    //            }
    //
    //            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
    //                ForEach(viewModel.movies) { movie in
    //                    MovieCard(movie: movie, type: .grid)
    //                }
    //            }
    //        }
    //    }
    //
    //    var searchedList: some View {
    //        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
    //            ForEach(viewModel.searchedMovies) { movie in
    //                MovieCard(movie: movie, type: .grid)
    //            }
    //        }
    //        .padding(.top, 20)
    //    }
}
