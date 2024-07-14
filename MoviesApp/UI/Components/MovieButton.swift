//
//  MovieButton.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

enum MovieButtonStyle {
    case play, normal, badge
}

struct MovieButtonIcon {
    let name: String
    var tint: Color = .white
}

struct MovieButtonTitle {
    let text: String
    var tint: Color = .white
}

struct MovieButton: View {
    let title: MovieButtonTitle
    var icon: MovieButtonIcon = .init(name: "info.circle")
    var style: MovieButtonStyle = .normal
    
    var body: some View {
        Button {
            
        } label: {
            if style == .normal {
                VStack(spacing: 3) {
                    Image(systemName: icon.name)
                        .foregroundStyle(icon.tint)
                        .frame(width: 24, height: 24)
                    Text(title.text)
                        .poppins(.medium, 13.64)
                        .foregroundStyle(title.tint)
                }
            } else if style == .play {
                HStack {
                    Image(systemName: icon.name)
                        .foregroundStyle(icon.tint)
                    Text(title.text)
                        .poppins(.black, 13.64)
                        .foregroundStyle(title.tint)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    Color.playBtn.cornerRadius(4)
                )
            } else {
                VStack(spacing: 0) {
                    Text(title.text)
                        .poppins(.bold, 7)
                        .foregroundStyle(title.tint)
                }
                .padding(1.8)
                .border(title.tint, width: 1)
            }
        }
    }
}

#Preview {
    MovieButton(title: .init(text: "Info"), icon: .init(name: "info.circle", tint: .green))
}
