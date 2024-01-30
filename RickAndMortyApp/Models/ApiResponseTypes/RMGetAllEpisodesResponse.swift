//
//  RMGetAllEpisodesResponse.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 30.01.24.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    let info: RMGetAllEpisodesResponseInfo
    let results: [RMEpisode]
    
    struct RMGetAllEpisodesResponseInfo: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
