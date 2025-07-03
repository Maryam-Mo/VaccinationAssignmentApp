//
//  AddVaccinationDelegate.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

protocol AddVaccinationDelegate: AnyObject {
    func addVaccinationViewController(vc: AddVaccinationViewController, dose: Dose)
}
