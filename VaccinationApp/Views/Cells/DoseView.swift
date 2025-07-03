//
//  DoseView.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class DoseView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseLightSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dateKeyLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseSubtitle
        label.text = Constants.Strings.date
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateKeyLabel, dateLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let clinicKeyLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseSubtitle
        label.text = Constants.Strings.clinic
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clinicLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clinicStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [clinicKeyLabel, clinicLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateStack, clinicStack])
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let editIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "pencil", withConfiguration: config)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "d MMMM, yyyy"
        return formatter
    }()
    
    init(dose: Dose) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.Colors.lightGreen
        layer.cornerRadius = 8
        setupViews()
        configure(with: dose)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }
    
    private func setupViews() {
        addSubview(headerStack)
        addSubview(editIcon)
        addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            headerStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -40),
            
            editIcon.centerYAnchor.constraint(equalTo: headerStack.centerYAnchor),
            editIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            editIcon.widthAnchor.constraint(equalToConstant: 20),
            editIcon.heightAnchor.constraint(equalToConstant: 20),
            
            infoStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            infoStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func configure(with dose: Dose) {
        titleLabel.text = dose.title
        subtitleLabel.text = dose.addedBy
        guard let date = dose.date else { return }
        dateLabel.text = dateFormatter.string(from: date)
        if let clinic = dose.clinic, !clinic.isEmpty {
            clinicLabel.text = clinic
            clinicStack.isHidden = false
        } else {
            clinicStack.isHidden = true
        }
        clinicLabel.text = dose.clinic
        editIcon.isHidden = dose.addedBy != Constants.Strings.byYou
    }
    
}
