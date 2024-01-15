//
//  RMtabBarController.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 12.01.24.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMtabBarController: UITabBarController {
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    // MARK: - Private Methods
    
    private func setupTabs() {
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodesViewController()
        let settingsVC = RMSettingsViewController()
        
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let characterNav = UINavigationController(rootViewController: charactersVC)
        let locationsNav = UINavigationController(rootViewController: locationsVC)
        let episodeNav = UINavigationController(rootViewController: episodesVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        characterNav.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        
        locationsNav.tabBarItem = UITabBarItem(
            title: "Location",
            image: UIImage(systemName: "globe"),
            tag: 1
        )
        
        episodeNav.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "tv"),
            tag: 3
        )
        
        settingsNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 4
        )
        
        for nav in [characterNav, locationsNav, episodeNav, settingsNav] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [
                characterNav,
                locationsNav,
                episodeNav,
                settingsNav
            ],
            animated: true
        )
    }
}
