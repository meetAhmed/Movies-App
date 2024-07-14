//
//  TopMovieView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

struct TopMovieView: View {
    var movie: Movie? = nil
    
    var itemWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * 0.5
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let movie {
                    ImageView(
                        itemWidth: itemWidth,
                        itemHeight: itemHeight,
                        movie: movie,
                        imageType: .poster,
                        radius: 0
                    )
                    
                    LinearGradient(
                        colors: [
                            .black.opacity(0.45),
                            .black.opacity(0),
                            .black.opacity(0.75),
                            .black
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                } else {
                    PlaceholderImage(itemWidth: itemWidth, itemHeight: itemHeight)
                }
            }
            
            VStack {
                HStack {
                    MovieButton(title: .init(text: "Top\n10"), style: .badge)
                    Text("#2 in Pakistan Today")
                        .poppins(.bold, 13.72)
                }
                
                HStack(alignment: .center, spacing: 25) {
                    MovieButton(title: .init(text: "My List"), icon: .init(name: "plus", tint: .white))
                    MovieButton(title: .init(text: "Play", tint: .black), icon: .init(name: "play.fill", tint: .black), style: .play)
                    MovieButton(title: .init(text: "Info"), icon: .init(name: "info.circle", tint: .white))
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -50)
        }
        .redacted(reason: movie == nil ? .placeholder : [])
    }
}
