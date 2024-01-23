//
//  NftCollectionViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 23.01.2024.
//

import UIKit
import Kingfisher

class NftCollectionViewCell: UICollectionViewCell {
    
    static let nftCollectionViewCellIdentifier = "nftCollectionViewCell"
    
    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var ratingView: RatingView = {
        let rating = RatingView()
        return rating
    }()
    
    func setupCell(with item: NftItem) {
        if let imageUrl = item.images.first {
            coverImage.kf.indicatorType = .activity
            coverImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        ratingView.rating = item.rating
        
        setupSubviews()
        setupLayout()
    }
}
// MARK: - Layout configuration
private extension NftCollectionViewCell {
    func setupSubviews() {
        [coverImage, ratingView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: contentView.bounds.width),
            
            ratingView.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
