//
//  MainVCViewModel.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/8/24.
//

import Foundation


final class PhotoViewModel {
    // MARK: - Properties
    var dataSource: DataSource!
    var snapShot = DataSourceSnapShot()
    var networkingService = Variable.networkingService
    var urlString = Variable.urlString
    
    // MARK: - LifeCycle
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        networkingService.fetchCatData(urlString: urlString) { (currentPhoto: [PhotoModel]?) in
            DispatchQueue.main.async {
                ConfigureCellMethod.shared.photoModel = currentPhoto
            }
        }
    }
    
    func applySnapshot(photos: [PhotoModel]) {
        snapShot = DataSourceSnapShot()
        snapShot.appendSections([.grid])
        snapShot.appendItems(photos, toSection: .grid)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    
}

