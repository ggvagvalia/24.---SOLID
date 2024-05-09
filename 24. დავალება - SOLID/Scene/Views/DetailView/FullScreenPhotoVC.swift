//
//  FullScreenPhotoVC.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import UIKit

class FullScreenPhotoVC: UIViewController {
    // MARK: - Properties
    private var dataSource: DataSource!
    private var snapShot = DataSourceSnapShot()
    private let itemsPerRow: CGFloat = 1
    private let viewModel: FullScreenPhotoViewModel
    
    let photosCollectionView: CustomCollectionView = {
        let view = CustomCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.layoutIfNeeded()
        return view
    }()
    
    let fullPhotoView: CustomImageView = {
        let view = CustomImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }()
    
    init(viewModel: FullScreenPhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
        viewModel.viewDidLoad()
        configureCollectionViewDataSource()
        reloadData()
    }
    
    func setupUI() {
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(photosCollectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        
        photosCollectionView.dataSource = dataSource
        photosCollectionView.collectionViewLayout = layout
        photosCollectionView.isPagingEnabled = true
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: photosCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> MainVCCollectionViewCell in
            let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCCollectionViewCell.cellIdentifier, for: indexPath) as! MainVCCollectionViewCell
            ConfigureCellMethod.shared.configure(cell: mainCell, at: indexPath)
            return mainCell
        })
    }
    
    private func reloadData() {
        ConfigureCellMethod.shared.photosUpdated = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.photosCollectionView.reloadData()
                self.applySnapshot(photos: ConfigureCellMethod.shared.photoModel ?? [])
            }
        }
    }
    
    private func applySnapshot(photos: [PhotoModel]) {
        snapShot = DataSourceSnapShot()
        snapShot.appendSections([.grid])
        snapShot.appendItems(photos, toSection: .grid)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
}
