//
//  Constants.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import UIKit

struct Constants {
    struct Colors {
        static let background = UIColor(hex: 0xFAF5EB)
        static let darkGreen = UIColor(hex: 0x004C3B)
    }
    
    struct Fonts {
        static let regularTitle = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let regularSubtitle = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let lightHeader = UIFont.systemFont(ofSize: 16, weight: .light)
        static let boldHeader = UIFont.systemFont(ofSize: 32, weight: .bold)
        static let linkButton = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
    struct Strings {
        static let vaccination = "Vaccinationer"
        static let takenDoses = "Tagna doser"
        static let username = "Maryam Moein"
        static let readMore = "Läs mer på Doktor.se  "
        static let url = "https://doktor.se"
    }
    
    struct Spacing {
        static let cellAspectRatio: CGFloat = 0.6
        static let padding: CGFloat = 16
    }
    
    struct Identifiers {
        static let vaccineCell = "VaccineCell"
    }
}
