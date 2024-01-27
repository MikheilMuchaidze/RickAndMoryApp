//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 15.01.24.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    // MARK: - Private Properties
    
    private let character: RMCharacter
    private var requestUrl: URL? {
        URL(string: character.url)
    }
    
    // MARK: - Public Properties
    
    public var title: String {
        character.name.uppercased()
    }
    public enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    // MARK: - Private Methods
    
    private func setupSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(
                viewModels: [
                    .init(
                        value: character.status.text,
                        type: .status
                    ),
                    .init(
                        value: character.gender.rawValue,
                        type: .gender
                    ),
                    .init(
                        value: character.type,
                        type: .type
                    ),
                    .init(
                        value: character.species,
                        type: .species
                    ),
                    .init(
                        value: character.origin.name,
                        type: .origin
                    ),
                    .init(
                        value: character.location.name,
                        type: .location
                    ),
                    .init(
                        value: character.created,
                        type: .created
                    ),
                    .init(
                        value: "\(character.episode.count)",
                        type: .episodeCount
                    )
                ]
            ),
            .episodes(viewModels: character.episode.compactMap {
                    RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
                }
            )
        ]
    }
    
    // MARK: - Public Properties
    
    public func createPhotoSectionLayout()  -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout()  -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 10
        section.contentInsets.trailing = 10
        return section
    }
    
    public func createEpisodeSectionLayout()  -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
