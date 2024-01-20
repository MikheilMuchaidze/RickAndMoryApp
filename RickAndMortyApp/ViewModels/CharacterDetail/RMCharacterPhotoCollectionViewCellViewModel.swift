//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 20.01.24.
//

import UIKit

final class RMCharacterPhotoCollectionViewCellViewModel {
    // MARK: - Private Properties
    
    private let imageUrl: URL?
    
    // MARK: - Init
    
    init(
        imageUrl: URL?
    ) {
        self.imageUrl = imageUrl
    }
    
    // MARK: - Public Methods
    
    public func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.donwloadImage(imageUrl, completion: completion)
    }
}
