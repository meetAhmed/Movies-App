//
//  Optional.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import Foundation

extension Optional where Wrapped == String {
    var stringValue: String {
        guard let self else { return "" }
        return self
    }
}
