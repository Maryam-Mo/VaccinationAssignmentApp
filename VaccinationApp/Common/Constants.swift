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
        static let lightGreen = UIColor(hex: 0xC4F1BE)
        static let darkGray = UIColor(hex: 0xC9C3BD)
    }
    
    struct Fonts {
        static let regularTitle = UIFont.systemFont(ofSize: 18, weight: .regular)
        static let regularSubtitle = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let lightHeader = UIFont.systemFont(ofSize: 16, weight: .light)
        static let boldHeader = UIFont.systemFont(ofSize: 32, weight: .bold)
        static let linkButton = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let doseTitle = UIFont.systemFont(ofSize: 16, weight: .semibold)
        static let doseSubtitle = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let doseLightSubtitle = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    struct Strings {
        static let vaccination = "Vaccinationer"
        static let takenDoses = "Tagna doser"
        static let username = "Maryam Moein"
        static let readMore = "Läs mer på Doktor.se  "
        static let url = "https://doktor.se"
        static let appliedDoses = "Genomförda doser"
        static let nextDose = "Nästa dos:"
        static let date = "Datum"
        static let clinic = "Klinik"
        static let byYou = "Tillagd av dig"
    }
    
    struct Spacing {
        static let cellAspectRatio: CGFloat = 0.6
        static let padding: CGFloat = 16
    }
    
    struct Identifiers {
        static let vaccineCell = "VaccineCell"
    }
}
