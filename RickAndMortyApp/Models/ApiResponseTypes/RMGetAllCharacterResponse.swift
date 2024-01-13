//
//  RMGetAllCharacterResponse.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import Foundation

struct RMGetAllCharacterResponse: Codable {
    let info: RMGetAllCharacterResponseInfo
    let results: [RMCharacter]
    
    struct RMGetAllCharacterResponseInfo: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
