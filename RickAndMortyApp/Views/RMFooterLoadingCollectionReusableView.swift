//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 15.01.24.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    // MARK: - Identifier
    
    static let cellIdentifier = "RMFooterLoadingCollectionReusableView"
    
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
        backgroundColor = .systemBackground
        addSubViews(spinner)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
        
    // MARK: - Private Methods
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public Methods
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
