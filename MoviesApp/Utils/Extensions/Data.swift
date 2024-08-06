//
//  Data.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import Foundation

extension Data {
    func decode<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}
