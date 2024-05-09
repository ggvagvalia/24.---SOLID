//
//  FullScreenExtensions.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import Foundation
import UIKit


extension FullScreenPhotoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConfigureCellMethod.shared.numberOfRaws()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCCollectionViewCell.cellIdentifier, for: indexPath) as! MainVCCollectionViewCell
        ConfigureCellMethod.shared.configure(cell: mainCell, at: indexPath)
        return mainCell
    }
    
    func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        photosCollectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
}
