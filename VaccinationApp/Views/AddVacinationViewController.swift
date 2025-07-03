//
//  AddVacinationViewController.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class AddVaccinationViewController: UIViewController {
    private let vaccine: Vaccine
    
    init(vaccine: Vaccine) {
        self.vaccine = vaccine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0xFA/255.0, green: 0xF5/255.0, blue: 0xEB/255.0, alpha: 1.0)
    }
}
