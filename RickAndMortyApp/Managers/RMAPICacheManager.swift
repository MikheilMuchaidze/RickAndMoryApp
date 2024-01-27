//
//  RMAPICacheManager.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 27.01.24.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPICacheManager {
    // MARK: - Private Properties
    
    /// Property halding cache type for a particular response
    /// We have several cases of endpoint in RMEndpoint enum
    /// So we have separeted cache for each of them rather then one single one
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    
    // MARK: - Init
    
    init() {
        setupCache()
    }
    
    // MARK: - Public Methods
    
    /// Method which retrieves data from cache if its exists in it
    /// - Parameters:
    ///   - endpoint: Endpoint to get cache information  from this property -> cacheDictionary
    ///   - url: Url as a key for searching in cache
    /// - Returns: Returns data from cache is it exists or nil
    public func cachedReponse(
        for endpoint: RMEndpoint,
        url: URL?
    ) -> Data? {
        guard 
            let targetCache = cacheDictionary[endpoint],
            let url
        else {
            return nil
        }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    /// Method which saves API response in cache
    /// - Parameters:
    ///   - endpoint: Endpoint to get cache information  from this property -> cacheDictionary for saving in it
    ///   - url: Url as a key for searching in cache
    ///   - data: Data to save into cache
    public func setCache(
        for endpoint: RMEndpoint,
        url: URL?,
        data: Data
    ) {
        guard
            let targetCache = cacheDictionary[endpoint],
            let url
        else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private Methods
    
    private func setupCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
