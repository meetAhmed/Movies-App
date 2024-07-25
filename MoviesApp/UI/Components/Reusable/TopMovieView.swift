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
                    MImageView(movie: movie)
                        .frame(width: itemWidth, height: itemHeight)
                        .cornerRadius(0)
                        .imageType(.poster)
                    
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
                    VStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                    }
                    .frame(width: itemWidth, height: itemHeight, alignment: .center)
                }
            }
            
            VStack {
                HStack {
                    MButton(title: .init(text: "Top\n10"), style: .badge)
                    Text("#2 in Pakistan Today")
                        .poppins(.bold, 13.72)
                        .foregroundStyle(Color.white)
                }
                
                HStack(alignment: .center, spacing: 25) {
                    MButton(title: .init(text: "My List"), icon: .init(name: "plus", tint: .white))
                    MButton(title: .init(text: "Play", tint: .black), icon: .init(name: "play.fill", tint: .black), style: .play)
                    MButton(title: .init(text: "Info"), icon: .init(name: "info.circle", tint: .white))
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -50)
        }
        .redacted(reason: movie == nil ? .placeholder : [])
    }
}
