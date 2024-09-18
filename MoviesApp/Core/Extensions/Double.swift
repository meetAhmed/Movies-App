//
//  Double.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 27/01/2023.
//

import Foundation

extension Double {
    var asString: String {
        String(format: "%.1f", self)
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asString
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asString
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asString
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asString
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asString
            
        default:
            return "\(sign)\(self)"
        }
    }
}
