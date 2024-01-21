//
//  RMLocation.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 12.01.24.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
