//
//  RMLocation.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 12.01.24.
//

import Foundation

struct RMLocation: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
