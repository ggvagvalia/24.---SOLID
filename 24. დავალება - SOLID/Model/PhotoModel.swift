//
//  PhotoModel.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/8/24.
//

import Foundation

struct PhotoModel: Decodable, Hashable {
    var id: String?
    var urls: URLS?
    
    struct URLS: Decodable, Hashable {
        var raw: String?
        var small: String?
        var regular: String?
    }
}
