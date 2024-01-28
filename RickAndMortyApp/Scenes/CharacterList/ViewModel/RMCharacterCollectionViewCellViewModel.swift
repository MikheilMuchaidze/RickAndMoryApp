//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import Foundation
import UIKit

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    // MARK: - Private Properties
    
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - Public Properties
    
    public let characterName: String
    public var characterStatusText: String {
        "Status: \(characterStatus.text)"
    }

    // MARK: - Init
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    // MARK: - Public Methods
    
    public func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoader.shared.donwloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
    static func == (
        lhs: RMCharacterCollectionViewCellViewModel,
        rhs: RMCharacterCollectionViewCellViewModel
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
