//
//  Color.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

extension Color {
    static var primary: Color {
        Color("Primary")
    }
    
    static var appBackground: Color {
        Color("Background")
    }
    
    static var placeholder: Color {
        Color("Placeholder")
    }
    
    static var searchBox: Color {
        Color("SearchBox")
    }
    
    static var playBtn: Color {
        Color("PlayBtn")
    }
}

extension Color {
    var uiColor: UIColor {
        UIColor(self)
    }
}
