//
//  Font.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

extension View {
    func poppins(_ font: Poppins, _ size: CGFloat = 14) -> some View {
        self.font(.custom(font.fontName, size: size))
    }
    
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}

enum Poppins: String {
    case black
    case bold
    case light
    case medium
    
    var fontName: String {
        "Poppins-\(self.rawValue.capitalized)"
    }
}
