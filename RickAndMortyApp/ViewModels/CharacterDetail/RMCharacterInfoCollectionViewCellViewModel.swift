//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 20.01.24.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    // MARK: - Private Properties
    
    private let value: String
    private let title: String
    
    // MARK: - Init
    
    init(
        value: String,
        title: String
    ) {
        self.value = value
        self.title = title
    }
}
