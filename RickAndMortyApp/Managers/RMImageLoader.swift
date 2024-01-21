//
//  RMImageLoader.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 16.01.24.
//

import Foundation
import UIKit

/// Class responsible for loading an image and also for caching it
final class RMImageLoader {
    // MARK: - Private Properties
    
    private var imageDataCache = NSCache<NSString, UIImage>()
    
    // MARK: - Public Properties
    
    static let shared = RMImageLoader()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Get content with URL
    /// - Parameters:
    ///   - url: Source url`
    ///   - completion: Callback
    public func donwloadImage(
        _ url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as UIImage))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self else { return }
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            guard let value = UIImage(data: data) else { return }
            imageDataCache.setObject(value, forKey: key)
            completion(.success(value))
        }
        task.resume()
    }
}
