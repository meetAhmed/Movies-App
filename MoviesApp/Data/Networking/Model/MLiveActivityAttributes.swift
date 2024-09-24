//
//  MLiveActivityAttributes.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 24/09/2024.
//

import ActivityKit

struct MLiveActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        let trailerState: MovieTrailerState
    }
    
    public enum MovieTrailerState: Float, Codable, Hashable, CaseIterable {
        case preparing = 1
        case playing
        case stopped
        
        var desc: String {
            switch self {
            case .preparing:
                return "Preparing video"
            case .playing:
                return "Playing video"
            case .stopped:
                return "Stopping video"
            }
        }
    }

    var movieTitle: String
}
