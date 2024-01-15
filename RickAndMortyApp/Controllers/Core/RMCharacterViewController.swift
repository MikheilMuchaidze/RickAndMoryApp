//
//  RMCharacterViewController.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 13.01.24.
//

import UIKit

/// Controller to show and search characters
final class RMCharacterViewController: UIViewController {
    // MARK: - Private Properties
    
    private let characterListView = RMCharacterListView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setupView()
    }
    
    // MARK: - Private Merthods
    
    private func setupView() {
        view.addSubview(characterListView)
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RMCharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let characterDetailVC = RMCharacterDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
