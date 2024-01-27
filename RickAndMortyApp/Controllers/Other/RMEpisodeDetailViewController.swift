//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 27.01.24.
//

import UIKit

/// View Controller to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel: RMEpisodeDetailViewViewModel
    
    // MARK: - Init
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(enpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuppoerted")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
    }
}
