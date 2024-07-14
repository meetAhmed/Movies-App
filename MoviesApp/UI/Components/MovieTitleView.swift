//
//  MovieTitleView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

struct MovieTitleView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .tracking(1.25)
            .poppins(.bold, 20)
            .hAlign(.leading)
            .padding(.top, 15)
    }
}

#Preview {
    MovieTitleView("Trending")
}
