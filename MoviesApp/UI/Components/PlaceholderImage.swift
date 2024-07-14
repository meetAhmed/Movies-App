//
//  PlaceholderImage.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

struct PlaceholderImage: View {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    var placeholderImage: String = "photo.circle.fill"
    var placeholderImageSize: CGFloat = 90
    var background: Color = .appBackground.opacity(0.25)
    
    var body: some View {
        ZStack {
            background
            
            Image(systemName: placeholderImage)
                .resizable()
                .frame(width: placeholderImageSize, height: placeholderImageSize)
                .foregroundStyle(Color.white.opacity(0.8))
        }
        .frame(width: itemWidth, height: itemHeight)
    }
}

#Preview {
    PlaceholderImage(itemWidth: 200, itemHeight: 200)
}
