//
//  DetailViewController.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import UIKit

class DetailViewController: UIViewController, AddVaccinationDelegate {
    private let viewModel: DetailViewModel
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameLabel = UILabel()
    private let titleLabel = UILabel()
    private let linkButton = UIButton(type: .system)
    private let sectionLabel = UILabel()
    private var nextDoseView: NextDoseView?
    private let dosesStack = UIStackView()
    private let addButton = UIButton(type: .system)
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
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
        setupLinkButton()
        setupSectionLabel()
        setupNextDoseSection()
        setupTakenDoses()
        setupAddButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        linkButton.layer.cornerRadius = linkButton.bounds.height / 2
        addButton.layer.cornerRadius = addButton.bounds.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Strings.vaccination
        reloadDoseRows()
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
        titleLabel.text = viewModel.vaccine.name
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Spacing.padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
            
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
        ])
    }
    
    private func setupLinkButton() {
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.setTitle(Constants.Strings.readMore, for: .normal)
        linkButton.titleLabel?.font = Constants.Fonts.linkButton
        linkButton.setTitleColor(.black, for: .normal)
        linkButton.layer.cornerRadius = linkButton.bounds.size.height / 2
        linkButton.layer.borderWidth = 2
        linkButton.layer.borderColor = Constants.Colors.darkGreen.cgColor
        linkButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        linkButton.clipsToBounds = true
        let icon = UIImage(
            systemName: "arrow.up.right.square",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        )
        linkButton.setImage(icon, for: .normal)
        linkButton.tintColor = .black
        linkButton.semanticContentAttribute = .forceRightToLeft
        linkButton.showsMenuAsPrimaryAction = false
        linkButton.addTarget(self, action: #selector(openDoktor), for: .touchUpInside)
        contentView.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            linkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
        ])
    }
    
    private func setupSectionLabel() {
        guard !viewModel.vaccine.takenDoses.isEmpty else { return }
        
        sectionLabel.font = Constants.Fonts.regularTitle
        sectionLabel.text = Constants.Strings.appliedDoses
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sectionLabel)
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 20),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
        ])
        
        sectionLabel.accessibilityIdentifier = "sectionLabel"

    }
    
    private func setupNextDoseSection() {
        guard let last = viewModel.lastTakenDate, viewModel.hasPendingDose else { return }
        if let nextDate = Calendar.current.date(byAdding: .year, value: 5, to: last) {
            let banner = NextDoseView(date: nextDate)
            banner.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(banner)
            nextDoseView = banner
            
            var rowHeight = 0
            let width = view.bounds.width - 32
            if !viewModel.vaccine.dosesWithClinic.isEmpty, let doseWithClinic = viewModel.vaccine.dosesWithClinic.first {
                rowHeight = Int(measureRowHeight(for: doseWithClinic, width: width))
            } else if let dose = viewModel.vaccine.doses.first {
                rowHeight = Int(measureRowHeight(for: dose, width: width))
            }
            
            NSLayoutConstraint.activate([
                banner.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: Constants.Spacing.padding),
                banner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
                banner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.padding),
                banner.heightAnchor.constraint(equalToConstant: CGFloat(rowHeight))
            ])
        }
    }
    
    private func setupTakenDoses() {
        dosesStack.axis = .vertical
        dosesStack.spacing = 8
        dosesStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dosesStack)
        
        let topAnchor = (nextDoseView != nil)
        ? nextDoseView!.bottomAnchor
        : sectionLabel.bottomAnchor
        
        NSLayoutConstraint.activate([
            dosesStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dosesStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.padding),
            dosesStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.padding),
            dosesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
    
    private func setupAddButton() {
        addButton.accessibilityIdentifier = "addDoseButton"
        addButton.setTitle(Constants.Strings.addDose, for: .normal)
        addButton.titleLabel?.font = Constants.Fonts.subtitle
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = Constants.Colors.darkGreen
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(addDose), for: .touchUpInside)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Spacing.padding),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Spacing.padding),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Spacing.padding),
            addButton.heightAnchor.constraint(equalToConstant: Constants.Spacing.buttonHeight),
        ])
        
        scrollView.contentInset.bottom = Constants.Spacing.buttonHeight + Constants.Spacing.padding + view.safeAreaInsets.bottom
        scrollView.scrollIndicatorInsets.bottom = scrollView.contentInset.bottom
    }
    
    
    private func reloadDoseRows() {
        loadViewIfNeeded()
        dosesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let sorted = viewModel.vaccine.takenDoses
          .sorted { $0.date! > $1.date! }
        sorted.forEach { dosesStack.addArrangedSubview(DoseView(dose: $0)) }
    }
    
    @objc private func openDoktor() {
        guard let url = URL(string: Constants.Strings.url) else { return }
        UIApplication.shared.open(url)
    }
    
    private func measureRowHeight(for dose: Dose, width: CGFloat) -> CGFloat {
        let view = DoseView(dose: dose)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let target = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        return view.systemLayoutSizeFitting(target, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel
        ).height
    }
    
    @objc private func addDose() {
        let addVC = AddVaccinationViewController(vaccine: viewModel.vaccine)
        let nav = UINavigationController(rootViewController: addVC)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            let hundredPercent = UISheetPresentationController.Detent.custom(
                identifier: .init("hundredPercent")
            ) { context in
                return context.maximumDetentValue * 1
            }
            
            sheet.detents = [hundredPercent, .large()]
            
            sheet.selectedDetentIdentifier = hundredPercent.identifier
            
            sheet.preferredCornerRadius = 16
        }
        addVC.delegate = self
        present(nav, animated: false, completion: nil)
    }
    
    func addVaccinationViewController(vc: AddVaccinationViewController, dose: Dose) {
        vc.dismiss(animated: true)
        viewModel.addDose(dose: dose)
        reloadDoseRows()
    }
}
