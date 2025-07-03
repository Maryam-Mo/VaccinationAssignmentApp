//
//  Extensions.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
}
