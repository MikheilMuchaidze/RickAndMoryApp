//
//  RMCharacterListViewControllerViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import Foundation

protocol RMCharacterListViewControllerViewModelProtocol: AnyObject {
    func getCellCount() -> Int
    func getCellViewModelForConfiguration(with index: Int) -> RMCharacterCollectionViewCellViewModel
    func getSelectedCharacter(with index: Int) -> RMCharacter
    func getApiInfoNextString() -> String?
}

/// View Model to handle character list view logic
final class RMCharacterListViewControllerViewModel: RMCharacterListViewControllerViewModelProtocol {
    // MARK: - Private Properties
    
    private var characters: [RMCharacter] = [] {
        didSet {
            characters.forEach {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharacterResponse.RMGetAllCharacterResponseInfo? = nil
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
    private func getIndexForInsertion(results: [RMCharacter]) -> [IndexPath] {
        var indexPathsToAdd: [IndexPath] = []
        
        let originalCount = characters.count
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
    
    /// Fetch initail set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharacterResponse.self
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let results = responseModel.results
                characters = results
                apiInfo = info
                DispatchQueue.main.async {
                    self.updateModel?(.initialLoad)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed (paginatipn)
    public func fetchAdditionalCharacters(url: URL) {
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
            expecting: RMGetAllCharacterResponse.self
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let moreResults = responseModel.results
                apiInfo = info
                let getIndexForInsertion = self.getIndexForInsertion(results: moreResults)
                characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.updateModel?(.paginationLoad(getIndexForInsertion))
                    self.isLoadingMore = false
                }
            case .failure(let error):
                print(String(describing: error))
                self.isLoadingMore = false
            }
        }
    }
    
    public func getSelectedCharacter(with index: Int) -> RMCharacter {
        characters[index]
    }
    
    public func getCellViewModelForConfiguration(with index: Int) -> RMCharacterCollectionViewCellViewModel {
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
