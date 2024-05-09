//
//  MainVC.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/8/24.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    let photoViewModel: PhotoViewModel
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    private let photosCollectionView: CustomCollectionView = {
        let view = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    // MARK: - LifeCycle
    init(photoViewModel: PhotoViewModel) {
        self.photoViewModel = photoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        photoViewModel.viewDidLoad()
        configureCollectionViewDataSource()
        reloadData()
    }
    
    
    // MARK: - SetupUI
    func SetupUI() {
        navigationItem.title = "გალერეა"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 32.0)]
        view.addSubview(photosCollectionView)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = photoViewModel.dataSource
        
        NSLayoutConstraint.activate([
            photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func configureCollectionViewDataSource() {
        photoViewModel.dataSource = DataSource(collectionView: photosCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> MainVCCollectionViewCell in
            let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCCollectionViewCell.cellIdentifier, for: indexPath) as! MainVCCollectionViewCell
            ConfigureCellMethod.shared.configure(cell: mainCell, at: indexPath)
            return mainCell
        })
    }
    
    private func reloadData() {
        ConfigureCellMethod.shared.photosUpdated = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.photosCollectionView.reloadData()
                self?.photoViewModel.applySnapshot(photos: ConfigureCellMethod.shared.photoModel ?? [])
            }
        }
    }
    
    
    
    func navigateToFullImageVC(with photo: PhotoModel) {
        let fullScreenPhotoViewModel = FullScreenPhotoViewModel(selectedPhoto: photo, allPhotos: photoViewModel.dataSource.snapshot().itemIdentifiers)
        let detailsVC = FullScreenPhotoVC(viewModel: fullScreenPhotoViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

