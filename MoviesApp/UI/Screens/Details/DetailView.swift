//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    
    init(movie: Movie) {
        self._vm = StateObject(wrappedValue: DetailViewModel(movie: movie))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    MImageView(movie: vm.movie)
                        .imageType(.backdrop)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                        .cornerRadius(0)
                    
                    if let movieDetails = vm.movieDetails {
                        MovieInfoView(movieDetails: movieDetails)
                        
                        MovieDescriptionView(movieDetails: movieDetails)
                    } else {
                        ProgressView()
                            .foregroundStyle(Color.white)
                    }
                    if let movieImages = vm.movieImages {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                            ForEach(movieImages.backdrops, id: \.filePath) { image in
                                MImageView(imageUrl: image.urlString)
                                    .imageType(.backdrop)
                                    .frame(width: geometry.size.width * 0.28, height: geometry.size.width * 0.28)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.black)
        .environment(\.colorScheme, .dark)
        .addCustomBackButton()
        .task {
            async let movieDetails: Void = vm.fetchMovieDetails()
            async let movieImages: Void = vm.fetchMovieImages()
            
            await movieDetails
            await movieImages
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: dev.movie)
    }
}

private extension DetailView {}
