//
//  ImageCache.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import UIKit

class MImageManager {
    static let shared = MImageManager()
    
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 25
        return cache
    }()
    
    private var service = MoviesNetworkingService()
    
    func getImage(urlString: String, shoudCacheImage: Bool = true) async -> UIImage? {
        if let image = cache.object(forKey: urlString.trim() as NSString) {
            return image
        }
        
        do {
            let imageData = try await service.fetchData(api: .init(endpoint: .custom(urlString)))
            if let image = UIImage(data: imageData) {
                if shoudCacheImage {
                    cache.setObject(image, forKey: urlString.trim() as NSString)
                }
                return image
            }
        } catch {
            MErrorHandler.process(error)
        }
        
        return nil
    }
}
