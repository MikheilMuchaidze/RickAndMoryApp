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
    
    // MARK: - Init
    
    init(enpointUrl: URL?) {
        self.enpointUrl = enpointUrl
        fetchEpisodeData()
    }
    
    // MARK: - Private Methods
    
    private func fetchEpisodeData() {
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
                print(String(describing: responseModel))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
