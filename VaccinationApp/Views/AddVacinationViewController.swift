//
//  AddVacinationViewController.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class AddVaccinationViewController: UIViewController, UITextFieldDelegate {
    private let vaccine: Vaccine
    private var selectedDose: String?
    private var selectedDate: Date?
    weak var delegate: AddVaccinationDelegate?
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()
    private let doseFieldLabel = UILabel()
    private let dosePicker = UIButton(type: .system)
    private let dateFieldLabel = UILabel()
    private let dateField = PaddedTextField()
    private lazy var datePicker = UIDatePicker()
    private lazy var dateToolbar = UIToolbar()
    private let clinicFieldLabel = UILabel()
    private let clinicField = PaddedTextField()
    private let saveButton = UIButton(type: .system)
    
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
        setupSubviews()
        configure()
        setupDosePickerMenu()
        setupDatePicker()
        updateSaveButtonState()
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dosePicker.layer.cornerRadius = dosePicker.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
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
    
    private func setupSubviews() {
        [nameLabel, titleLabel, doseFieldLabel, dosePicker, dateFieldLabel, dateField, clinicFieldLabel, clinicField, saveButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Spacing.padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Spacing.padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Spacing.padding),
            
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            doseFieldLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            doseFieldLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            doseFieldLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            dosePicker.topAnchor.constraint(equalTo: doseFieldLabel.bottomAnchor, constant: 8),
            dosePicker.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dosePicker.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            dosePicker.heightAnchor.constraint(equalToConstant: Constants.Spacing.buttonHeight),
            
            dateFieldLabel.topAnchor.constraint(equalTo: dosePicker.bottomAnchor, constant: Constants.Spacing.padding),
            dateFieldLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateFieldLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            dateField.topAnchor.constraint(equalTo: dateFieldLabel.bottomAnchor, constant: 8),
            dateField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            dateField.heightAnchor.constraint(equalToConstant: Constants.Spacing.buttonHeight),
            
            clinicFieldLabel.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: Constants.Spacing.padding),
            clinicFieldLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            clinicFieldLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            clinicField.topAnchor.constraint(equalTo: clinicFieldLabel.bottomAnchor, constant: 8),
            clinicField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            clinicField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            clinicField.heightAnchor.constraint(equalToConstant: Constants.Spacing.buttonHeight),
            
            saveButton.topAnchor.constraint(greaterThanOrEqualTo: clinicField.bottomAnchor, constant: Constants.Spacing.padding),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Spacing.padding),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.Spacing.buttonHeight)
        ])
        
    }
    
    private func configure() {
        nameLabel.font = Constants.Fonts.lightHeader
        nameLabel.text = Constants.Strings.username
        
        titleLabel.font = Constants.Fonts.boldHeader
        titleLabel.text = vaccine.name
        
        [doseFieldLabel, dateFieldLabel, clinicFieldLabel].forEach {
            $0.font = Constants.Fonts.doseSubtitle
        }
        doseFieldLabel.text = Constants.Strings.selectDose
        dateFieldLabel.text = Constants.Strings.selectDate
        clinicFieldLabel.text = Constants.Strings.clinic
        
        dosePicker.setTitle(Constants.Strings.selectDose, for: .normal)
        dosePicker.setTitleColor(Constants.Colors.darkGreen, for: .normal)
        dosePicker.backgroundColor = Constants.Colors.lightGreen
        dosePicker.contentHorizontalAlignment = .leading
        dosePicker.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        
        dateField.placeholder = Constants.Strings.dateAb
        dateField.font = Constants.Fonts.doseSubtitle
        dateField.textColor = Constants.Colors.darkGreen
        dateField.backgroundColor = Constants.Colors.lightGreen
        dateField.layer.cornerRadius = 4
        dateField.textInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        dateField.delegate = self

        clinicField.placeholder = Constants.Strings.clinicPlaceholder
        clinicField.backgroundColor = Constants.Colors.background
        clinicField.borderStyle = .none
        clinicField.layer.borderWidth = 1
        clinicField.layer.borderColor = UIColor.black.cgColor
        clinicField.layer.cornerRadius = 8
        clinicField.textInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        
        saveButton.setTitle(Constants.Strings.save, for: .normal)
        saveButton.backgroundColor = Constants.Colors.darkGreen
        saveButton.tintColor = UIColor.black
        saveButton.titleLabel?.font = Constants.Fonts.subtitle
        
        dosePicker.accessibilityIdentifier = "dosePickerButton"
        dateField.accessibilityIdentifier = "dateField"
        saveButton.accessibilityIdentifier = "saveButton"
    }
    
    private func setupDosePickerMenu() {
        let actions = (1...3).map { idx in
            UIAction(title: "Dos \(idx)") { [weak self] action in
                self?.selectedDose = action.title
                self?.dosePicker.setTitle(action.title, for: .normal)
                self?.updateSaveButtonState()
            }
        }
        dosePicker.menu = UIMenu(title: "", children: actions)
        dosePicker.showsMenuAsPrimaryAction = true
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "sv_SE")
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Klar", style: .done, target: self, action: #selector(dismissDatePicker))
        dateToolbar.setItems([flex, done], animated: false)
        dateToolbar.sizeToFit()
        dateField.inputAccessoryView = dateToolbar
        dateField.inputView = datePicker
    }
    
    @objc private func dateChanged() {
        selectedDate = datePicker.date
        let df = DateFormatter()
        df.locale = Locale(identifier: "sv_SE")
        df.dateFormat = "d MMMM, yyyy"
        dateField.text = df.string(from: datePicker.date)
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let enabled = (selectedDose != nil) && (selectedDate != nil)
        saveButton.isEnabled = enabled
        saveButton.backgroundColor = enabled
        ? Constants.Colors.darkGreen
        : UIColor.lightGray
        saveButton.setTitleColor(enabled ? .white : .black, for: .normal)
        saveButton.alpha = enabled ? 1.0 : 0.5
    }
    
    @objc private func dismissDatePicker() {
        view.endEditing(true)
    }
    
    @objc private func save() {
        guard let title = selectedDose, let date = selectedDate else { return }
        let clinic = clinicField.text?.isEmpty == false ? clinicField.text : nil
        let dose = Dose(title: title, addedBy: Constants.Strings.byYou, date: date, clinic: clinic)
        delegate?.addVaccinationViewController(vc: self, dose: dose)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      if textField === dateField {
          selectedDate = datePicker.date
          updateDateFieldText()
      }
      return true
    }

    private func updateDateFieldText() {
        guard let date = selectedDate else { return }
        let df = DateFormatter()
        df.locale = Locale(identifier: "sv_SE")
        df.dateFormat = "d MMMM, yyyy"
        dateField.text = df.string(from: date)
        updateSaveButtonState()
    }
}
