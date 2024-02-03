//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 27.01.24.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    // MARK: - Private Properties
    
    private let enpointUrl: URL?
    
    // MARK: - Published Properties
    
    @Published var dataTuple: (RMEpisode, [RMCharacter])?
    
    // MARK: - Init
    
    init(enpointUrl: URL?) {
        self.enpointUrl = enpointUrl
    }
    
    // MARK: - Public Methods
    
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard
            let url = enpointUrl,
            let requet = RMRequest(url: url)
        else { return }
        
        RMService.shared.execute(
            requet,
            expecting: RMEpisode.self
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseModel):
                fetchRelatedCharacters(episode: responseModel)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests = episode.characters
            .compactMap { URL(string: $0) }
            .compactMap { RMRequest(url: $0) }
        var characters: [RMCharacter] = []
        
        requests.forEach {
            RMService.shared.execute(
                $0,
                expecting: RMCharacter.self
            ) { result in
                switch result {
                case .success(let character):
                    characters.append(character)
                case .failure:
                    break
                }
            }
        }
        
        dataTuple = (
            episode,
            characters
        )
    }
}
