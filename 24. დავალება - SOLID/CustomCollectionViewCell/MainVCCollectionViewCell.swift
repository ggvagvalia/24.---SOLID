//
//  MainVCCollectionViewCell.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/8/24.
//

import UIKit

class MainVCCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellIdentifier = "MainVCCollectionViewCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoImage: CustomImageView = {
        let view = CustomImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }()
    
    
    // MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - setupUI
    func setupUI() {
        addSubview(containerView)
        containerView.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            photoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    // MARK: - ConfigurePhoto
    func configure(with photo: PhotoModel) {
        if let imageUrlString = photo.urls?.regular,
           let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Error fetching image data: \(error)")
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        let imageBackground = UIImage(data: data)
                        self.photoImage.image = imageBackground
                    }
                }
            }.resume()
        } else {
            print("Invalid / missing image URL")
        }
    }
}
