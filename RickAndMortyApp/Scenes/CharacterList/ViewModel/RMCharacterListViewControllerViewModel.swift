//
//  RMCharacterListViewControllerViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import Foundation
import Combine

protocol RMCharacterListViewControllerViewModelProtocol: AnyObject {
    func getSelectedCharacter(with index: Int) -> RMCharacter
    func getApiInfoNextString() -> String?
}

/// View Model to handle character list view logic
final class RMCharacterListViewControllerViewModel: RMCharacterListViewControllerViewModelProtocol {
    // MARK: - Private Properties
    
    private var characters: [RMCharacter] = [] {
        didSet {
            let viewModels = characters.map {
                RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
            }
            cellViewModels = viewModels
        }
    }
    private var apiInfo: RMGetAllCharacterResponse.RMGetAllCharacterResponseInfo? = nil
    private(set) var isLoadingMore = false
    
    // MARK: - Published Properties
    
    @Published var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    // MARK: - Public Properties
    
    var shouldShowLoadMoreIndicator: Bool {
        apiInfo?.next != nil
    }
    
    // MARK: - Public Methods
    
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
            defer {
                self.isLoadingMore = false
            }
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let moreResults = responseModel.results
                apiInfo = info
                characters.append(contentsOf: moreResults)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func getSelectedCharacter(with index: Int) -> RMCharacter {
        characters[index]
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
