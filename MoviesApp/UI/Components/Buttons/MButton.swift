//
//  MovieButton.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import SwiftUI

enum MButtonStyle {
    case play, topIcon, badge, primary
}

struct MButtonIcon {
    let name: String
    var tint: Color = .white
}

struct MButtonTitle {
    let text: String
    var tint: Color = .white
}

typealias MButtonAction = () -> Void

struct MButton: View {
    let title: MButtonTitle
    var icon: MButtonIcon = .init(name: "info.circle")
    var style: MButtonStyle = .primary
    var action: MButtonAction? = nil
    var backgroundColor: Color = .primary
    var disabled = false
    
    init(title: MButtonTitle, action: MButtonAction? = nil) {
        self.title = title
        self.action = action
    }
    
    init(_ title: String, action: MButtonAction? = nil) {
        self.title = .init(text: title)
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            switch style {
            case .play:
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
                    backgroundColor.cornerRadius(4)
                )
            case .topIcon:
                VStack(spacing: 3) {
                    Image(systemName: icon.name)
                        .foregroundStyle(icon.tint)
                        .frame(width: 24, height: 24)
                    Text(title.text)
                        .poppins(.medium, 13.64)
                        .foregroundStyle(title.tint)
                }
            case .badge:
                VStack(spacing: 0) {
                    Text(title.text)
                        .poppins(.bold, 7)
                        .foregroundStyle(title.tint)
                }
                .padding(1.8)
                .border(title.tint, width: 1)
            case .primary:
                HStack(spacing: 3) {
                    Text(title.text)
                        .poppins(.medium, 13.64)
                        .foregroundStyle(title.tint)
                }
                .frame(height: 45)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(backgroundColor)
            }
        }
        .disabled(disabled)
    }
    
    func setIcon(_ name: String, tint: Color = .white) -> MButton {
        var copy = self
        copy.icon = .init(name: name, tint: tint)
        return copy
    }
    
    func setStyle(_ newStyle: MButtonStyle) -> MButton {
        var copy = self
        copy.style = newStyle
        return copy
    }
    
    func disableBtn() -> MButton {
        var copy = self
        copy.backgroundColor = .playBtn
        copy.disabled = true
        return copy
    }
}

#Preview {
    MButton("Action Button")
}
