//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import UIKit
import SwiftUI

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    // MARK: - Private Properties
    
    private let settingsSwiftUIController = UIHostingController(
        rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap { RMSettingsCellViewViewModel(type: $0) }
            )
        )
    )
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        navigationItem.largeTitleDisplayMode = .never
        addSwiftUIController()
    }
    
    // MARK: - Private Methods
    
    private func addSwiftUIController() {
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
