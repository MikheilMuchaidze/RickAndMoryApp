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
    
    // MARK: - Private Properties

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        addSubViews(spinner, seasonLabel, nameLabel, airDateLabel)
        addConstraints()
        addDefaultShadows()
        registerForTraitChanges(traitsToListenWhenChanged, action: #selector(configureView))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    // MARK: - ObjC Methods
    
    @objc
    private func configureView() {
        addDefaultShadows()
    }
    
    // MARK: - Private Methods
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: (contentView.bounds.height)/2),
            
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 0.3),
            seasonLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: airDateLabel.topAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20),
            
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 0.3),
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: contentView.bounds.height - 30),
            airDateLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20),
        ])
    }
    
    private func isLoading(_ active: Bool) {
        seasonLabel.isHidden = active
        nameLabel.isHidden = active
        airDateLabel.isHidden = active
        active
        ? spinner.startAnimating()
        : spinner.stopAnimating()
    }
    
    // MARK: - Public Methods
    
    public func configure(_ viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        isLoading(true)
        viewModel.registerForData { [weak self] data in
            // Main Queue
            guard let self else { return }
            defer { self.isLoading(false) }
            seasonLabel.text = "Episode "+data.episode
            nameLabel.text = data.name
            airDateLabel.text = "Aired on "+data.air_date
        }
        viewModel.fetchEpisode()
    }
}
