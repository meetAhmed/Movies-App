//
//  String.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import Foundation

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNotEmpty: Bool {
        self.trim().isEmpty == false
    }
}
