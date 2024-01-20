//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 20.01.24.
//

import UIKit

/// Collectionview cell responseble for showing character image on character details page
final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMCharacterPhotoCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public func configure(_ viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        
    }
}
