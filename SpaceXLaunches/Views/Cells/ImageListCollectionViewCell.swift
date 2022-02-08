//
//  ImageListCollectionViewCell.swift
//  SpaceXLaunches
//
//  Created by Sarp  on 7.02.2022.
//

import UIKit

class ImageListCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.image = UIImage(named: "launch")
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setData(_ imageURL: String?) {
        guard let imageURL = imageURL else {
            return
        }
        imageView.downloadImage(from: imageURL)
    }
}
