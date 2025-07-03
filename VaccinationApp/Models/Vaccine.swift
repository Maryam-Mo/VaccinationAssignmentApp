//
//  Vaccine.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import Foundation

struct Vaccine: Identifiable, Equatable  {
    
    let id: UUID
    let name: String
    var doses: [Dose]
    
    var takenDoses: [Dose] { doses.filter { $0.isTaken } }
    var pendingDoses: [Dose] { doses.filter { !$0.isTaken } }
    var dosesWithClinic: [Dose] { doses.filter{ !($0.clinic?.isEmpty ?? true) }}
    var nextDose: Dose? { pendingDoses.first }
    var takenCount: Int { takenDoses.count }
    var totalCount: Int { doses.count }
    
    static func == (lhs: Vaccine, rhs: Vaccine) -> Bool {
        return lhs.id == rhs.id
    }
}
