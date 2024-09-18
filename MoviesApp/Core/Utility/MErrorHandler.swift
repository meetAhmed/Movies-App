//
//  MErrorHandler.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import Foundation

protocol MErrorHandler {
    func process(_ error: Error?)
}

class MErrorHandlerImpl: MErrorHandler {
    func process(_ error: Error?) {
#if DEBUG
        print("MErrorHandler \(String(describing: error))")
#endif
    }
}
