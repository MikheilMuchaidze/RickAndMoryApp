//
//  RMtabBarController.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 12.01.24.
//

import UIKit

final class RMtabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let locationsVC = RMLocationViewController()
        let charactersVC = RMCharacterViewController()
        let episodesVC = RMEpisodesViewController()
        let settingsVC = RMSettingsViewController()
        
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let locationsNav = UINavigationController(rootViewController: locationsVC)
        let characterNav = UINavigationController(rootViewController: charactersVC)
        let episodeNav = UINavigationController(rootViewController: episodesVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        locationsNav.tabBarItem = UITabBarItem(
            title: "Location",
            image: UIImage(systemName: "globe"),
            tag: 1
        )
        
        characterNav.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person"),
            tag: 2
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
        
        for nav in [locationsNav, characterNav, episodeNav, settingsNav] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [
                locationsNav,
                characterNav,
                episodeNav,
                settingsNav
            ],
            animated: true
        )
    }
}
