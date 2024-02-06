//
//  RMSettingsCellViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 05.02.24.
//

import UIKit

struct RMSettingsCellViewViewModel: Identifiable {
    // MARK: - Object Idetifier
    
    let id = UUID()
    
    // MARK: - Public Properties
    
    public var image: UIImage? {
        type.displayImage
    }
    public var imageContainerColor: UIColor {
        type.iconContainerColor
    }
    public var title: String {
        type.displayTitle
    }
    public let onTapHandler: (RMSettingsOption) -> Void?
    public let type: RMSettingsOption
    
    // MARK: - Init
    
    init(
        type: RMSettingsOption,
        onTapHandler: @escaping (RMSettingsOption) -> Void?
    ) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
}
