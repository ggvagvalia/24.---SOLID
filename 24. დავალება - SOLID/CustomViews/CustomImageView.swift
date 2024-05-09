//
//  CustomImageView.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/9/24.
//

import UIKit

class CustomImageView: UIImageView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureImageView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureImageView() {
            translatesAutoresizingMaskIntoConstraints = false
            clipsToBounds = true
            contentMode = .scaleAspectFill
            image = UIImage(systemName: "photo")
    }

}
