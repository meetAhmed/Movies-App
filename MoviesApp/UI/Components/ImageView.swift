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
    var radius: CGFloat = 16
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                   
            } else {
                PlaceholderImage(itemWidth: itemWidth, itemHeight: itemHeight)
            }
        }
        .task {
            image = await ImageCache.shared.getImage(urlString: movie.imageFullPath(type: imageType))
        }
        .scaledToFill()
        .frame(width: itemWidth, height: itemHeight, alignment: imageType == .backdrop ? .center : .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(itemWidth: UIScreen.main.bounds.width, itemHeight: 500, movie: dev.movie)
    }
}
