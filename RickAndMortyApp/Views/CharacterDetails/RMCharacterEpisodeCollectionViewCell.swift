//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 20.01.24.
//

import UIKit

/// Collectionview cell responseble for showing character episodes in which it was participant on character details page
final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        addConstraints()
        addDefaultShadows()
        registerForTraitChanges(traitsToListenWhenChanged, action: #selector(configureView))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - ObjC Methods
    
    @objc
    private func configureView() {
        addDefaultShadows()
    }
    
    // MARK: - Private Methods
    
    private func addConstraints() {
        
    }
    
    // MARK: - Public Methods
    
    public func configure(_ viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
    }
}
