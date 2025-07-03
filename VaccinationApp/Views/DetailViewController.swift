//
//  DetailViewController.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class DetailViewController: UIViewController {
    private let vaccine: Vaccine
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()
    
    init(vaccine: Vaccine) {
        self.vaccine = vaccine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = Constants.Colors.background
        setupScrollView()
        setupHeader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Strings.vaccination
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    private func setupHeader() {
        nameLabel.font = Constants.Fonts.lightHeader
        nameLabel.text = Constants.Strings.username
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        titleLabel.font = Constants.Fonts.boldHeader
        titleLabel.text = vaccine.name
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Spacing.padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
            
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
        ])
    }
}
