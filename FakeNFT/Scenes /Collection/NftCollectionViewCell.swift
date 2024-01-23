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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        button.setImage(UIImage(named: "CartEmpty"), for: .normal)
        button.tintColor = .ypBlack
        return button
    }()
    
    func setupCell(with item: NftItem) {
        if let imageUrl = item.images.first {
            coverImage.kf.indicatorType = .activity
            coverImage.kf.setImage(with: URL(string: imageUrl))
        }
        ratingView.rating = item.rating
        nameLabel.text = item.name
        priceLabel.text = "\(item.price) ETH"
        
        setupSubviews()
        setupLayout()
    }
}
// MARK: - Private routines
private extension NftCollectionViewCell {
    func setupSubviews() {
        [coverImage, ratingView, verticalStackView, cartButton].forEach {
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
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 4),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            cartButton.heightAnchor.constraint(equalToConstant: 40),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            cartButton.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 4),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.leadingAnchor.constraint(equalTo: verticalStackView.trailingAnchor)
        ])
    }
    
    @objc func didTapCartButton() {}
    
    @objc func didTapFavouriteButton() {}
}
