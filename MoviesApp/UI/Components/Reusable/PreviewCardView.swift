//
//  PreviewCardView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

struct PreviewCardView: View {
    let movie: Movie

    var itemWidth: CGFloat {
        UIScreen.main.bounds.width / 4
    }
    
    var body: some View {
        MImageView(movie: movie)
            .frame(width: itemWidth, height: itemWidth)
            .cornerRadius(0)
            .clipShape(Circle())
    }
}

struct PreviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCardView(movie: dev.movie)
    }
}
