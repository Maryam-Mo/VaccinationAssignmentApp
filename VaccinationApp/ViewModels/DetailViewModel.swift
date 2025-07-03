//
//  DetailViewModel.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import Foundation

class DetailViewModel {
    private let vaccinesListVM: VaccinesListViewModel
    private let index: Int
    
    var vaccine: Vaccine {
        get { vaccinesListVM.vaccines[index] }
        set { vaccinesListVM.vaccines[index] = newValue }
    }
    
    init(vaccine: Vaccine, vaccinesListVM: VaccinesListViewModel, index: Int) {
        self.vaccinesListVM = vaccinesListVM
        self.index = index
    }
    
    var hasPendingDose: Bool {
        vaccine.totalCount > vaccine.takenCount
    }
    
    var lastTakenDate: Date? {
        vaccine.takenDoses.last?.date
    }
    
    func addDose(dose: Dose) {
        var vaccine = vaccine
        vaccine.doses.append(dose)
        vaccinesListVM.vaccines[index] = vaccine
    }
}
