//
//  RMEndpoint.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import Foundation

/// Represents unique API endpoint
@frozen 
enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
