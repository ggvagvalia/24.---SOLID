//
//  ConfigureCellMethod.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import Foundation

class ConfigureCellMethod {
    static let shared = ConfigureCellMethod()
    
    public var photoModel: [PhotoModel]? {
        didSet { photosUpdated?() }
    }
    
    public var photosUpdated: (() -> Void)?
    
    // MARK: - cellForRawAt
    func configure(cell: MainVCCollectionViewCell, at index: IndexPath) {
        if let photo = self.photoModel?[index.row] {
            cell.configure(with: photo)
        } else {
            print ("no photoo")
        }
    }
    
    // MARK: - numberOfRawsInSection
    func numberOfRaws() -> Int {
        self.photoModel?.count ?? 0
    }
    
}
