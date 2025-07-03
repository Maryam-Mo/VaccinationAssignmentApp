//
//  NextDoseView.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class NextDoseView: UIView {
    private let dashedBorder = CAShapeLayer()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Strings.nextDose
        label.font = Constants.Fonts.doseTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.doseSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(date: Date) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.Colors.darkGray
        layer.cornerRadius = 4
        setupViews()
        configure(date: date)
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func configure(date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "d MMMM, yyyy"
        dateLabel.text = formatter.string(from: date)
    }
    
    private func setupBorder() {
        dashedBorder.strokeColor = Constants.Colors.darkGreen.cgColor
        dashedBorder.fillColor = UIColor.clear.cgColor
        dashedBorder.lineWidth = 2
        dashedBorder.lineDashPattern = [6, 4]
        layer.addSublayer(dashedBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashedBorder.frame = bounds
        dashedBorder.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius
        ).cgPath
    }
}
