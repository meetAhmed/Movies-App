//
//  Build.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import Foundation

enum Build {
    static var API_KEY: String {
        guard let key = Bundle.main.infoDictionary?["Api_key"] as? String, !key.trim().isEmpty else {
            fatalError("API KEY Not Found")
        }
        return key.replacingOccurrences(of: "\"", with: "")
    }
}
