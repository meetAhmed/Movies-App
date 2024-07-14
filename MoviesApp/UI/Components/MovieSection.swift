//
//  MovieSection.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import SwiftUI

struct MovieSection: View {
    let section: MovieSectionType
    let namespace: Namespace.ID
    @Binding var selected: MovieSectionType
    
    var body: some View {
        Text(section.rawValue.capitalized)
            .poppins(selected == section ? .medium : .light, 16)
            .background(
                ZStack {
                    if selected == section {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.searchBox)
                            .frame(height: 3)
                            .offset(y: 20)
                            .matchedGeometryEffect(id: "MovieSection", in: namespace)
                    }
                }
            )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    selected = section
                }
            }
    }
}

struct MovieSection_Previews: PreviewProvider {
    static var previews: some View {
        MovieSection(section: .overview, namespace: Namespace().wrappedValue, selected: .constant(.overview))
    }
}
