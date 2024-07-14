//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Namespace private var namespace
    @State var selectedSection: MovieSectionType = .overview
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                imageSection
               
                // MARK: Stats and (Overview, Review) sections 
                VStack {
                    stats
                    
                    sections
                }
                .padding(.horizontal)
                .padding(.top, backdropImageHeight / 2)
            }
            .padding(.bottom)
        }
        .ignoresSafeArea()
        .background(Color.appBackground)
        .environment(\.colorScheme, .dark)
        .overlay(backButton, alignment: .topLeading)
        .task {
//            await vm.fetchMovieReviews()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: dev.movie)
            .environmentObject(HomeViewModel())
    }
}

private extension DetailView {
    var posterImageHeight: CGFloat {
        UIScreen.main.bounds.height * 0.5
    }
    
    var backdropImageHeight: CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
    var backdropImageOffset: CGFloat {
        UIScreen.main.bounds.height * 0.24
    }
}

private extension DetailView {
    var imageSection: some View {
        ZStack(alignment: .leading) {
            ImageView(itemWidth: UIScreen.main.bounds.width, itemHeight: posterImageHeight, movie: movie, imageType: .poster)
                .shadow(
                    color: Color.placeholder,
                    radius: 10,
                    x: 0,
                    y: 10
                )
            
            HStack(alignment: .bottom, spacing: 15) {
                ImageView(itemWidth: backdropImageHeight, itemHeight: backdropImageHeight, movie: movie, imageType: .backdrop)
                    
                Text(movie.title)
                    .poppins(.bold, 25)
                    .frame(height: backdropImageHeight * 0.38)
                    .minimumScaleFactor(0.1)
                    .padding(.bottom, 10)
            }
            .padding()
            .offset(y: backdropImageOffset)
        }
    }
    
    var stats: some View {
        HStack {
            Image(systemName: "calendar")
            Text(movie.releaseDate)
            Spacer()
            if movie.voteAverage > 0 {
                VStack {
                    Text(movie.voteAverage.asString)
                        .poppins(.bold, 50)
                    Text(movie.voteCount, format: .number)
                }
            }
        }
        .poppins(.medium, 18)
    }
    
    var sections: some View  {
        VStack {
            HStack(spacing: 25) {
                ForEach(MovieSectionType.allCases, id: \.self) { section in
                    MovieSection(section: section, namespace: namespace, selected: $selectedSection)
                }
            }
            .padding(.vertical, 20)
            
            Text("\(vm.error?.localizedDescription ?? "")")
            
//            VStack(alignment: .leading) {
//                switch selectedSection {
//                case .overview:
//                    Text(movie.overview)
//                case .reviews:
//                    ForEach(vm.reviews) { review in
//                        ReviewCard(review: review)
//                    }
//                }
//            }
        }
    }
    
    var backButton: some View {
        Button {
//            vm.selectedMovie = nil
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline)
                .padding(15)
                .foregroundColor(.white)
                .background(Color.appBackground)
                .cornerRadius(10)
                .shadow(color: Color.placeholder, radius: 4)
                .padding()
            
        }
    }
}

enum MovieSectionType: String, CaseIterable {
    case overview, reviews
}
