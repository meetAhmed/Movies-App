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

enum MLogger {
    private static let isDebug = true
    
    static func output(_ str: String?) {
        isDebug ? print("MLogger \(String(describing: str))") : ()
    }
}
