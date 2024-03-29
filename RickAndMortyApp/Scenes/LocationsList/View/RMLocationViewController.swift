//
//  RMLocationViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import UIKit

/// Controller to show and search locations
final class RMLocationViewController: UIViewController {
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        navigationItem.largeTitleDisplayMode = .never
    }
}
