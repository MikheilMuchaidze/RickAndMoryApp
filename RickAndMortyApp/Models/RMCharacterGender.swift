//
//  RMCharacterGender.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import Foundation

enum RMCharacterGender: String, Codable {
    // "'Female', 'Male', 'Genderless' or 'unknown'
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
