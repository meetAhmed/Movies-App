//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var showGallery = false
    
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
                        
                        MButton("View Gallery") {
                            showGallery.toggle()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.horizontal)
                    } else {
                        MLoadingView()
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(vm.movie.title)
        .background(Color.black)
        .environment(\.colorScheme, .dark)
        .addCustomBackButton()
        .navigationDestination(isPresented: $showGallery) {
            UIViewControllerWrapper(viewController: GalleryVC(movie: vm.movie))
                .navigationTitle(vm.movie.title.trim())
                .addCustomBackButton()
        }
        .task {
            await vm.fetchMovieDetails()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: dev.movie)
    }
}
