//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import UIKit

/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    // MARK: - Private Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(
            ofSize: 18,
            weight: .medium
        )
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = .systemFont(
            ofSize: 16,
            weight: .regular
        )
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubViews(imageView, nameLabel, statusLabel)
        addDefaultShadows()
        addConstraints()
        registerForTraitChanges(traitsToListenWhenChanged, action: #selector(configureView))
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - ObjC Methods
    
    @objc
    private func configureView() {
        addDefaultShadows()
    }
    
    // MARK: - Private Methods
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
        ])
    }
    
    // MARK: - Public Methods

    public func configure(_ viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case .failure:
                break
            }
        }
    }
}
