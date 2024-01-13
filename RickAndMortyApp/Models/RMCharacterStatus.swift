//
//  RMCharacterStatus.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import Foundation

enum RMCharacterStatus: String, Decodable {
    // 'Alive', 'Dead' or 'unknown'
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}
