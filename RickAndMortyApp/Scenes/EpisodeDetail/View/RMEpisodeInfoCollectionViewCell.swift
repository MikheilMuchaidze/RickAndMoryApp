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
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    private let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.textColor = .label
        valueLabel.font = .systemFont(
            ofSize: 20,
            weight: .regular
        )
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = .zero
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        return valueLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubViews(titleLabel, valueLabel)
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
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    // MARK: - Private Methods
    
    private func setupBorder() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
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
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
