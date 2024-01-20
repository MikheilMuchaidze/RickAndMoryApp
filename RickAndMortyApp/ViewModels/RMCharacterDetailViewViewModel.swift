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
    private var requestUrl: URL? {
        URL(string: character.url)
    }
    
    // MARK: - Public Properties
    
    public var title: String {
        character.name.uppercased()
    }
    public enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    public let sections = SectionType.allCases
    
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
}
