//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    // MARK: - Private Properties
    
    private let viewModel = RMSettingsViewViewModel(
        cellViewModels: RMSettingsOption.allCases.compactMap { RMSettingsCellViewViewModel(type: $0) }
    )
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        navigationItem.largeTitleDisplayMode = .never
    }
}
