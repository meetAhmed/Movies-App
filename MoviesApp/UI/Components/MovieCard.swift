//
//  MovieCard.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

struct MovieCard: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    let movie: Movie
    var type: MovieCardType = .poster

    var body: some View {
        VStack {
            ImageView(itemWidth: itemWidth, itemHeight: itemWidth, movie: movie)
                .onTapGesture {
//                    viewModel.selectedMovie = movie
                }
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: dev.movie, type: .poster)
            .environmentObject(HomeViewModel())
    }
}

private extension MovieCard {
    var itemWidth: CGFloat {
        UIScreen.main.bounds.width * type.widthPercent
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * type.heightPercent
    }
}

enum MovieCardType {
    case poster, topRated, grid
    
    var widthPercent: Double {
        switch self {
        case .poster:
            return 0.6
        case .topRated:
            return 0.38
        case .grid:
            return 0.3
        }
    }
    
    var heightPercent: Double {
        switch self {
        case .poster:
            return 0.38
        case .topRated:
            return 0.25
        case .grid:
            return 0.2
        }
    }
}
