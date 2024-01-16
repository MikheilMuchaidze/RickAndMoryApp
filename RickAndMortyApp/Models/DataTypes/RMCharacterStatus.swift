//
//  RMCharacterStatus.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    // 'Alive', 'Dead' or 'unknown'
    case alive = "Alive"
    case dead = "Dead"
    case `unknown`
    
    var text: String {
        switch self {
        case .alive:
            rawValue
        case .dead:
            rawValue
        case .unknown:
            "Unknown"
        }
    }
}
