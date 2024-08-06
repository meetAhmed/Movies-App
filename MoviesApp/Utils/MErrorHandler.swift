//
//  MErrorHandler.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import Foundation

enum MErrorHandler {
    private static let isDebug = true
    
    static func process(_ error: Error?) {
        isDebug ? print("MErrorHandler \(String(describing: error))") : ()
    }
}
