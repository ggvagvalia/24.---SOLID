//
//  FullScreenPhotoViewModel.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import Foundation

class FullScreenPhotoViewModel {
    
    var dataSource: DataSource!
    var snapShot = DataSourceSnapShot()
    private var photos: [PhotoModel]
    var currentIndex: Int = 0
    var networkingService = Variable.networkingService
    var urlString = Variable.urlString
    
    init(selectedPhoto: PhotoModel, allPhotos: [PhotoModel]) {
        self.photos = allPhotos
        
        if let index = allPhotos.firstIndex(where: { $0.id == selectedPhoto.id }) {
            self.currentIndex = index
        }
    }
    
    // MARK: - LifeCycle
    func viewDidLoad() {
        fetchData()
    }
    func fetchData() {
        networkingService.fetchCatData(urlString: urlString) { (currentPhoto: [PhotoModel]?) in
            guard let photos = currentPhoto else { return }
            DispatchQueue.main.async {
                self.photos = photos
                
                if self.currentIndex >= 0 && self.currentIndex < photos.count {
                    ConfigureCellMethod.shared.photoModel = Array(photos[self.currentIndex...])
                } else {
                    ConfigureCellMethod.shared.photoModel = photos
                }
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
