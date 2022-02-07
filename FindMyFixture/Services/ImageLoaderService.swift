//
//  ImageLoaderService.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoaderService {
    static let shared = ImageLoaderService()
    private init() { }
    private var cancellables = Set<AnyCancellable>()
    static var counter: Int = 0
    
    public func loadImage(for urlString: String, completionHandler: @escaping (Result<UIImage, FmfLoadError>) -> Void) {
        if let image = PhotoCacheManager.shared.getImage(for: urlString) {
            completionHandler(.success(image))
            return
        }
        guard let url: URL = URL(string: urlString)  else { return completionHandler(.failure(.urlLoadError))}
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { loadImage in
                if let loadImage = loadImage {
                    PhotoCacheManager.shared.add(urlString: urlString, image: loadImage)
                    Self.counter += 1
                    print("load HTTP: \(Self.counter)")
//                    print("loadImage: \(loadImage)")
                    
                    completionHandler(.success(loadImage))
                } else {
                    completionHandler(.failure(.imageLoadError))
                }
            }.store(in: &cancellables)
    }
    
}

class PhotoCacheManager {
    static var shared = PhotoCacheManager()
    private var count: Int = 0
    
    private init() {}
                        
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit  = 1024 * 1024 * 200 
        return cache
    }()
    
    public func add(urlString: String, image: UIImage) {
        photoCache.setObject(image, forKey: urlString as NSString)
    }
    
    public func getImage(for urlString: String) -> UIImage? {
        let out = photoCache.object(forKey: urlString as NSString)
        if let _ = out {
            count += 1
            print("get Image from Cache: \(count)")
        }
        return out
    }
    
}




