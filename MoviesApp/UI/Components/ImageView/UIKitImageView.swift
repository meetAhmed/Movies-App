//
//  MImageView+UIKit.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 06/08/2024.
//

import UIKit

class UIKitImageView: UIImageView {
    let placeholderImage = UIImage(named: "PlaceholderImage")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIKitImageView {
    func update(with movieImage: MovieImage) {
        Task {
            let image = await ImageCache.shared.getImage(urlString: movieImage.urlString)
            self.image = image
        }
    }
    
    func setPlaceholderImage() {
        image = placeholderImage
    }
}

private extension UIKitImageView {
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        setPlaceholderImage()
    }
}
