//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by mmuchaidze on 14.01.24.
//

import UIKit

extension UIView {
    /// Extension for adding multiple views to a subview
    /// - Parameter view: The view(s) to be added
    func addSubViews(_ view: UIView...) {
        view.forEach { addSubview($0) }
    }
}
