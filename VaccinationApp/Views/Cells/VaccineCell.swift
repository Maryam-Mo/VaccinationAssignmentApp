//
//  VaccineCell.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import UIKit

class VaccineCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.Identifiers.vaccineCell
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularTitle
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doseLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularSubtitle
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(doseLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with vaccine: Vaccine) {
        nameLabel.text = vaccine.name
        doseLabel.text = "\(Constants.Strings.takenDoses) \(vaccine.takenCount)/\(vaccine.doses.count)"
    }
}

