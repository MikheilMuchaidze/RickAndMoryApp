//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 15.01.24.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    // MARK: - Init
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuppoerted")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .never
    }
}
