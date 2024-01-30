//
//  RMSearchViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 30.01.24.
//

import UIKit

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    // MARK: - Private Properties
    
    private let config: Config
    
    // MARK: - Public Properties
    
    struct Config {
        enum `Type` {
            case character
            case location
            case episode
        }
        
        let type: `Type`
    }
    
    // MARK: - Init
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuppoerted")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
    }
}

