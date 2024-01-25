//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 14.01.24.
//

import UIKit

extension UIView {
    /// Extension for adding multiple views to a subview
    /// - Parameter view: The view(s) to be added
    public func addSubViews(_ view: UIView...) {
        view.forEach { addSubview($0) }
    }
    
    /// Extension for UIView to add default shadows effects
    public func addDefaultShadows() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: -4, height: 4)
        self.layer.shadowOpacity = 0.3
    }
    
    /// Array of traits which for registering and listening to
    public var traitsToListenWhenChanged: [UITrait] {
        [UITraitUserInterfaceStyle.self]
    }
}
