//
//  ImageView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct MImageView: View {
    var movie: Movie?
    var imageUrl: String?
    var width: CGFloat?
    var height: CGFloat?
    var cornerRadius: CGFloat = 15
    var imageType: MovieImageType = .any
    
    @State private var image: UIImage? = nil
    @Injected var imageManager: MImageManager!
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height, alignment: imageType == .backdrop ? .center : .topLeading)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                Image("PlaceholderImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
        }
        .task {
            guard let urlToUse = movie == nil ? imageUrl : movie?.imageFullPath(type: imageType) else { return }
            image = await imageManager.getImage(urlString: urlToUse, shoudCacheImage: true)
        }
    }
}

extension MImageView {
    func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> MImageView {
        var copy = self
        copy.width = width
        copy.height = height
        return copy
    }
    
    func imageType(_ type: MovieImageType) -> MImageView {
        var copy = self
        copy.imageType = type
        return copy
    }
    
    func cornerRadius(_ radius: CGFloat) -> MImageView {
        var copy = self
        copy.cornerRadius = radius
        return copy
    }
}

struct MImageView_Previews: PreviewProvider {
    static var previews: some View {
        MImageView(movie: dev.movie)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
    }
}
