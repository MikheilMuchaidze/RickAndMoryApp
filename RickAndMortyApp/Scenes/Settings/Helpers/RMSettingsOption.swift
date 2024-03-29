//
//  RMSettingsOption.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 05.02.24.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.circle.fill")
        case .contactUs:
            return UIImage(systemName: "phone.circle.fill")
        case .terms:
            return UIImage(systemName: "text.book.closed")
        case .privacy:
            return UIImage(systemName: "lock.fill")
        case .apiReference:
            return UIImage(systemName: "link.circle.fill")
        case .viewSeries:
            return UIImage(systemName: "arrow.up.right.video.fill")
        case .viewCode:
            return UIImage(systemName: "swift")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewSeries:
            return .systemPink
        case .viewCode:
            return .systemPurple
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Police"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://iosacademy.io")
        case .terms:
            return URL(string: "https://iosacademy.io/terms")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/MikheilMuchaidze/RickAndMoryApp")
        }
    }
}
