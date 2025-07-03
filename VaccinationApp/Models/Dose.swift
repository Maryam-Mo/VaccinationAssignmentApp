//
//  Dose.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import Foundation

struct Dose {
    let title: String
    let addedBy: String
    let date: Date?
    let clinic: String?
    
    var isTaken: Bool { date != nil }
}
