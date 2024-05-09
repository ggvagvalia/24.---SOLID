//
//  CollectionViewExtensions.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import Foundation
import UIKit


enum Section: Int, CaseIterable {
    case grid
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, PhotoModel>
typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<Section, PhotoModel>
