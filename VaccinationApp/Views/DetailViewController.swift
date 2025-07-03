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
}
