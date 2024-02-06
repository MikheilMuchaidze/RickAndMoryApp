//
//  RMSettingsViewController.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 13.01.24.
//

import UIKit
import SwiftUI
import SafariServices

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    // MARK: - Private Properties
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
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
        let settingsSwiftUIController = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap { RMSettingsCellViewViewModel(type: $0) { [weak self] optionTapped in
                        guard let self else { return }
                        handleTap(option: optionTapped)
                    } }
                )
            )
        )
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.main.isMainThread else { return }
        if let url = option.targetURL {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            
        }
    }
}
