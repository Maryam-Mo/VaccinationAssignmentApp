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
        modalPresentationStyle = .pageSheet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.background
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Lägg till dos"
        let close = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(close)
        )
        close.tintColor = .label
        navigationItem.leftBarButtonItem = close
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func close() {
        dismiss(animated: false, completion: nil)
    }
}
