//
//  RMSettingsCellViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 05.02.24.
//

import UIKit

struct RMSettingsCellViewViewModel: Identifiable, Hashable {
    // MARK: - Object Idetifier
    
    let id = UUID()
    
    // MARK: - Private Properties
    
    private let type: RMSettingsOption
    
    // MARK: - Public Properties
    
    public var image: UIImage? {
        type.displayImage
    }
    
    public var imageContainerColoer: UIColor {
        type.iconContainerColor
    }
    
    public var title: String {
        type.displayTitle
    }
    
    // MARK: - Init
    
    init(type: RMSettingsOption) {
        self.type = type
    }
}
