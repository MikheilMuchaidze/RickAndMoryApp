//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 15.01.24.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    // MARK: - Private Properties
    
    private let character: RMCharacter
    
    // MARK: - Public Properties
    
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
}
