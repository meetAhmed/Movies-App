//
//  ContinueWatchingCardView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

struct Top10CardView: View {
    let count: Int
    let movie: Movie

    var itemWidth: CGFloat {
        UIScreen.main.bounds.width / 3
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text("\(count)")
                .poppins(.black, 100)
                .foregroundStyle(Color.white)
            MImageView(movie: movie)
                .frame(width: itemWidth, height: itemHeight)
                .offset(x: -20)
        }
    }
}

struct Top10CardView_Previews: PreviewProvider {
    static var previews: some View {
        Top10CardView(count: 1, movie: dev.movie)
    }
}
