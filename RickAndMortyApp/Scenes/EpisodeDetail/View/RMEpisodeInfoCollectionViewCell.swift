//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 04.02.24.
//

import UIKit

/// Single cell for a episode info
final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setupBorder()
        contentView.layer.masksToBounds = true
        addDefaultShadows()
        addConstraints()
        registerForTraitChanges(traitsToListenWhenChanged, action: #selector(configureView))
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private Methods
    
    private func setupBorder() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
    // MARK: - ObjC Methods
    
    @objc
    private func configureView() {
        addDefaultShadows()
        setupBorder()
    }
    
    // MARK: - Public Methods

    public func configure(_ viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
    }
}
