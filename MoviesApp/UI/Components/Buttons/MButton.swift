//
//  MovieButton.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

enum MButtonStyle {
    case play, normal, badge
}

struct MButtonIcon {
    let name: String
    var tint: Color = .white
}

struct MButtonTitle {
    let text: String
    var tint: Color = .white
}

struct MButton: View {
    let title: MButtonTitle
    var icon: MButtonIcon = .init(name: "info.circle")
    var style: MButtonStyle = .normal
    
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
    MButton(title: .init(text: "Info"), icon: .init(name: "info.circle", tint: .green))
}
