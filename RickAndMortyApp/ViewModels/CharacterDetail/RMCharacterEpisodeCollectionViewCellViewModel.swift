//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 20.01.24.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    // MARK: - Private Properties
    
    private let episodeDataUrl: URL?
    
    // MARK: - Init
    
    init(
        episodeDataUrl: URL?
    ) {
        self.episodeDataUrl = episodeDataUrl
    }
}
