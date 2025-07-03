//
//  ViewController.swift
//  VaccinationApp
//
//  Created by Maryam on 7/3/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel: VaccinesListViewModel
    
    init(viewModel: VaccinesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = VaccinesListViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = Constants.Colors.background
        setupNavigationView()
        setupCollectionView()
    }
    
    private func setupNavigationView() {
        navigationItem.title = Constants.Strings.vaccination
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    private func setupCollectionView() {
        collectionView.register(VaccineCell.self, forCellWithReuseIdentifier: Constants.Identifiers.vaccineCell)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            layout.estimatedItemSize = .zero
        }
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VaccineCell.reuseIdentifier, for: indexPath) as? VaccineCell else {
            return UICollectionViewCell()
        }
        let vaccine = viewModel.vaccine(at: indexPath.item)
        cell.configure(with: vaccine)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: floor(width), height: floor(width * Constants.Spacing.cellAspectRatio))
    }
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vaccine = viewModel.vaccine(at: indexPath.item)
        let detailVM = DetailViewModel(vaccine: vaccine, vaccinesListVM: viewModel, index: indexPath.item)
        let detailVC = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

