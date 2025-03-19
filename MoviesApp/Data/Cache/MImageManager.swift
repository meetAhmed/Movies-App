//
//  ImageCache.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 14/07/2024.
//

import UIKit

protocol MImageManager {
    func getImage(urlString: String, shoudCacheImage: Bool) async -> UIImage?
}

class MImageManagerImpl: MImageManager {
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 25
        return cache
    }()
    
    @Injected var service: MoviesNetworkingService!
    @Injected var errorHandler: MErrorHandler!
    
    func getImage(urlString: String, shoudCacheImage: Bool) async -> UIImage? {
        if let image = cache.object(forKey: urlString.trim() as NSString) {
            return image
        }
        
        do {
            let imageData = try await service.fetchData(api: APIConstructorImpl(endpoint: CustomEndpoint(customUrl: urlString)))
            if let image = UIImage(data: imageData) {
                if shoudCacheImage {
                    cache.setObject(image, forKey: urlString.trim() as NSString)
                }
                return image
            }
        } catch {
            errorHandler.process(error)
        }
        
        return nil
    }
}
