//
//  GalleryCell.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    static let identifier = "GalleryCell"
    
    let imageView = UIKitImageView(frame: .zero)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.setPlaceholderImage()
    }
}

extension GalleryCell {
    func update(_ image: MovieImage? = nil) {
        if let image {
            imageView.update(with: image)
        }
    }
}
