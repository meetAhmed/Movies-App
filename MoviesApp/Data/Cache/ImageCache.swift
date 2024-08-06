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
    private var service = MoviesNetworkingService()
    
    func getImage(urlString: String) async -> UIImage? {
        if let image = cache.object(forKey: urlString.trim() as NSString) {
            return image
        }
        
        do {
            let imageData = try await service.fetchData(api: .init(endpoint: .custom(urlString)))
            if let image = UIImage(data: imageData) {
//                cache.setObject(image, forKey: urlString.trim() as NSString)
                return image
            }
        } catch {
            MErrorHandler.process(error)
        }
        
        return nil
    }
}
