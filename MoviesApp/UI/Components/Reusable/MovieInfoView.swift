//
//  MovieInfoView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/07/2024.
//

import SwiftUI

struct MovieInfoView: View {
    let movieDetails: MovieDetails
    
    var body: some View {
        VStack(spacing: 0) {
            Text(movieDetails.title)
                .poppins(.bold, 22)
                .tracking(1.5)
                .lineSpacing(4)
            
            HStack(alignment: .center, spacing: 0) {
                Text("Rating \(String(format: "%.1f", movieDetails.voteAverage))  •  ")
                Text("\(movieDetails.runtime) min  •  ")
                Text(movieDetails.releaseDate)
            }
            .poppins(.light, 14)
            .foregroundColor(.white.opacity(0.75))
            .padding(.top, 4)
        }
        .multilineTextAlignment(.center)
        .padding(15)
    }
}

private extension MovieInfoView {}
