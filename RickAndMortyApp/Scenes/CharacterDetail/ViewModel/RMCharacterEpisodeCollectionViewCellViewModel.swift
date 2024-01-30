//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 20.01.24.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {
    // MARK: - Private Properties
    
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var episode : RMEpisode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    // MARK: - Init
    
    init(
        episodeDataUrl: URL?
    ) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    // MARK: - Public Methods
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard
            let url = episodeDataUrl,
            let request = RMRequest(url: url)
        else { return }
        
        isFetching = true
        
        RMService.shared.execute(
            request,
            expecting: RMEpisode.self
        ) { [weak self] reuslt in
            guard let self else { return }
            switch reuslt {
            case .success(let responseModel):
                DispatchQueue.main.async {
                    self.episode = responseModel
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (
        lhs: RMCharacterEpisodeCollectionViewCellViewModel,
        rhs: RMCharacterEpisodeCollectionViewCellViewModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
