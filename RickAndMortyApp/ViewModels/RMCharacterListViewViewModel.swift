//
//  RMCharacterListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import UIKit

/// Listener to update collection view if API call for fetching is succeeded
protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
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
    private var shouldShowLoadMoreIndicator: Bool {
        apiInfo?.next != nil
    }
    private var apiInfo: RMGetAllCharacterResponse.RMGetAllCharacterResponseInfo? = nil
    private var isLoadingMore = false
    
    // MARK: - Delegate
    
    weak var delegate: RMCharacterListViewViewModelDelegate?
    
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
                    self.delegate?.didLoadInitialCharacters()
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
                    self.delegate?.didLoadMoreCharacters(
                        with: getIndexForInsertion
                    )
                    self.isLoadingMore = false
                }
            case .failure(let error):
                print(String(describing: error))
                self.isLoadingMore = false
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & general cell deqeue

extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(cellViewModels[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView footer cell deqeue

extension RMCharacterListViewViewModel {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.cellIdentifier,
            for: indexPath
        ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }

        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        
        return CGSizeMake(collectionView.frame.width, 100)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}

// MARK: - CollectionView didselect

extension RMCharacterListViewViewModel {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - UIScrollViewDelegate

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMore,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] t in
            guard let self else { return }
            
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewHeight - 120) {
                fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
