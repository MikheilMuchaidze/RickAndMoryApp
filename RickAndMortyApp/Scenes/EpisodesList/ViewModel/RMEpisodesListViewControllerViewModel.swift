//
//  RMEpisodesListViewControllerViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 30.01.24.
//

import Foundation

protocol RMEpisodesListViewControllerViewModelProtocol: AnyObject {
    func getCellCount() -> Int
    func getCellViewModelForConfiguration(with index: Int) -> RMCharacterEpisodeCollectionViewCellViewModel
    func getSelectedCharacter(with index: Int) -> RMEpisode
    func getApiInfoNextString() -> String?
}

/// View Model to handle episode list view logic
final class RMEpisodesListViewControllerViewModel: RMEpisodesListViewControllerViewModelProtocol {
    // MARK: - Private Properties
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            episodes.forEach {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: $0.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllEpisodesResponse.RMGetAllEpisodesResponseInfo? = nil
    private(set) var isLoadingMore = false
    private var updateModel: ((UpdateModel) -> Void)?
    
    // MARK: - Public Properties
    
    var shouldShowLoadMoreIndicator: Bool {
        apiInfo?.next != nil
    }
    enum UpdateModel {
        case initialLoad
        case paginationLoad([IndexPath])
    }
    
    // MARK: - Private Methods
    
    /// Getting an index for a insertion in collection view
    /// - Returns: Array of indexpaths to insert in collection
    private func getIndexForInsertion(results: [RMEpisode]) -> [IndexPath] {
        var indexPathsToAdd: [IndexPath] = []
        
        let originalCount = episodes.count
        let newCount = results.count
        let total = originalCount + newCount
        let startingIndex = total - newCount
        indexPathsToAdd = Array(startingIndex..<(startingIndex + newCount)).compactMap { IndexPath(row: $0, section: 0) }
        
        return indexPathsToAdd
    }
    
    // MARK: - Public Methods
    
    public func registerForData(_ block: @escaping (UpdateModel) -> Void) {
        updateModel = block
    }
    
    /// Fetch initail set of episodes (20)
    public func fetchEpisodes() {
        RMService.shared.execute(
            .listEpisodesRequest,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let results = responseModel.results
                episodes = results
                apiInfo = info
                DispatchQueue.main.async {
                    self.updateModel?(.initialLoad)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional episodes are needed (paginatipn)
    public func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        guard let request = RMRequest(url: url) else {
            isLoadingMore = false
            print("Failed to create request")
            return
        }
        
        RMService.shared.execute(
            request,
            expecting: RMGetAllEpisodesResponse.self
        ) { [weak self] result in
            guard let self else { return }
            defer {
                self.isLoadingMore = false
            }
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let moreResults = responseModel.results
                apiInfo = info
                let getIndexForInsertion = self.getIndexForInsertion(results: moreResults)
                episodes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.updateModel?(.paginationLoad(getIndexForInsertion))
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func getSelectedCharacter(with index: Int) -> RMEpisode {
        episodes[index]
    }
    
    public func getCellViewModelForConfiguration(with index: Int) -> RMCharacterEpisodeCollectionViewCellViewModel {
        cellViewModels[index]
    }
    
    public func getCellCount() -> Int {
        cellViewModels.count
    }
    
    public func getShouldShowLoadMoreIndicatorValue() -> Bool {
        shouldShowLoadMoreIndicator
    }
    
    public func getisLoadingMoreValue() -> Bool {
        isLoadingMore
    }
    
    public func getApiInfoNextString() -> String? {
        apiInfo?.next
    }
}
