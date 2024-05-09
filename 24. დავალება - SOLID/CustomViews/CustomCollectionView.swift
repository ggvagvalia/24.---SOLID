//
//  CustomCollectionView.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import UIKit

class CustomCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    // MARK: - SetupCollectionView
    private func setupCollectionView() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("UICollectionViewFlowLayout error")
        }
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        register(MainVCCollectionViewCell.self, forCellWithReuseIdentifier: MainVCCollectionViewCell.cellIdentifier)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        
    }
}
