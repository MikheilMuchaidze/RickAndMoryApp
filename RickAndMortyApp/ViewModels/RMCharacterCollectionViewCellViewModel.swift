//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import Foundation

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
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
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
