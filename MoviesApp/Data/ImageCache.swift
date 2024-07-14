//
//  ImageCache.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(urlString: String) async -> UIImage? {
        if let image = cache.object(forKey: urlString.trimmingCharacters(in: .whitespacesAndNewlines) as NSString) {
            return image
        }
        
        if let image = await MoviesNetworkingService().downloadImage(urlString: urlString) {
            cache.setObject(image, forKey: urlString as NSString)
            return image
        }
        
        return nil
    }
}
