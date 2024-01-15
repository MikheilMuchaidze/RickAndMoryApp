//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import UIKit

/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Properties

    static let cellIdentifier = "RMCharacterCollectionViewCell"
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView, nameLabel, statusLabel)
        addConstraints()
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
    
    // MARK: - Private Methods
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            
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
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            case .failure:
                break
            }
        }
    }
}
