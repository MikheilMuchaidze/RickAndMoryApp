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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        addSubview(spinner)
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
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: (contentView.bounds.width)/2),
            spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: (contentView.bounds.height)/2),
        ])
    }
    
    private func isLoading(_ active: Bool) {
        active
        ? spinner.startAnimating()
        : spinner.stopAnimating()
    }
    
    // MARK: - Public Methods
    
    public func configure(_ viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        isLoading(true)
        viewModel.registerForData { [weak self] data in
            guard let self else { return }
            defer { self.isLoading(false) }
            print(data.name)
            print(data.air_date)
            print(data.episode)
        }
        viewModel.fetchEpisode()
    }
}
