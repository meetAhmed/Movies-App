//
//  ImageView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

enum MovieImageType {
    case poster, backdrop, any
}

struct ImageView: View {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let movie: Movie
    var imageType: MovieImageType = .any
    
    var body: some View {
        AsyncImage(url: URL(string: movie.imageFullPath(type: imageType))) { image in
            image
                .resizable()
        } placeholder: {
            ZStack {
                Color.placeholder
                
                Text(movie.title)
                    .poppins(.light, 14)
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: itemWidth, height: itemHeight)
        }
        .scaledToFill()
        .frame(width: itemWidth, height: itemHeight, alignment: imageType == .backdrop ? .center : .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(itemWidth: UIScreen.main.bounds.width, itemHeight: 500, movie: dev.movie)
    }
}
