//
//  RMRequest.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 13.01.24.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    /// Desired endpoint
    private let endpoint: RMEndpoint
    /// Path components to API if any
    private let pathCompoenets: Set<String>
    /// Qeury parameters to API if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        if !pathCompoenets.isEmpty {
            pathCompoenets.forEach { string += "/\($0)" }
        }
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Computed & constructed url
    public var url: URL? {
        URL(string: urlString)
    }
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathCompoenets: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: RMEndpoint,
        pathCompoenets: Set<String> = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathCompoenets = pathCompoenets
        self.queryParameters = queryParameters
    }
}
