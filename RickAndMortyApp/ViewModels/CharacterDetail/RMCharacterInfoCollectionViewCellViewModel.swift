//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Mikheil Muchaidze on 20.01.24.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    // MARK: - Private Properties
    
    private let type: `Type`
    private let value: String
    static let dateFromatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    // MARK: - Public Properties
    
    public var title: String {
        type.displayTitle
    }
    public var displayValue: String {
        if
            type == .created,
            let date = Self.dateFromatter.date(from: value)
        {
            return Self.shortDateFormatter.string(from: date)
        }
        return value.isEmpty
        ? "None"
        : value
    }
    public var iconImage: UIImage? {
        type.iconImage
    }
    public var tintColor: UIColor {
        type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemGreen
            case .location:
                return .systemPink
            case .created:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case
                    .status,
                    .gender,
                    .type,
                    .species,
                    .origin,
                    .location,
                    .created:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    // MARK: - Init
    
    init(
        value: String,
        type: `Type`
    ) {
        self.value = value
        self.type = type
    }
}
