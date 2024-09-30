//
//  ImageCacheManager.swift
//  ImageGalleryApp
//
//  Created by Mohammad Shariq on 01/10/24.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
   
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.absoluteString as NSString
       
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
        
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
