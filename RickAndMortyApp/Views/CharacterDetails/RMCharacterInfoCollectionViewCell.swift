//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 20.01.24.
//

import UIKit

/// Collectionview cell responseble for showing character information on character details page
final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private Methods
    
    private func addConstraints() {
        
    }
    
    // MARK: - Public Methods
    
    public func configure(_ viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        
    }
}
