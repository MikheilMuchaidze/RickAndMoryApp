//
//  RMCharacterListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject {
    // MARK: - Public Methods

    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let model):
                print("Example image url: "+String(model.results.first?.image ?? "No image"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(RMCharacterCollectionViewCellViewModel(
            characterName: "Misha",
            characterStatus: .alive,
            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        ))
        return cell
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
