//
//  MovieDescriptionView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/07/2024.
//

import SwiftUI

struct MovieDescriptionView: View {
    let movieDetails: MovieDetails
    
    var body: some View {
        VStack {
            if movieDetails.tagline.trim().isNotEmpty {
                Text(movieDetails.tagline.trim())
                    .poppins(.bold, 16)
            }
            
            Text(movieDetails.overview)
                .poppins(.medium, 14)
                .padding(.top)
        }
        .foregroundStyle(Color.black)
        .multilineTextAlignment(.center)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        )
        .padding(15)
    }
}
