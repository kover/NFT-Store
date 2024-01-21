//
//  cartTableViewCell.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 21.01.2024.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Cart.price", comment: "")
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cryptoPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Delete_button"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func deleteButtonTapped() {
        //todo: Реализовать удаление NFT из корзины
    }
    
    func configure(with cellModel: NftModel) {
        guard let fitstImageUrl = cellModel.images.first else {
            return
        }
        nftImageView.kf.setImage(with: URL(string:fitstImageUrl))
        nftImageView.layer.cornerRadius = 12
        titleLabel.text = cellModel.name
        ratingView.rating = cellModel.rating
        cryptoPriceLabel.text = String(describing: cellModel.price) + " ETH"
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(cryptoPriceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deleteButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        nftImageView.heightAnchor.constraint(equalToConstant: 108),
        nftImageView.widthAnchor.constraint(equalToConstant: 108),
        
        titleLabel.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 8),
        titleLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
        titleLabel.heightAnchor.constraint(equalToConstant: 22),
        
        ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        ratingView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        
        cryptoPriceLabel.bottomAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: -8),
        cryptoPriceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
        cryptoPriceLabel.heightAnchor.constraint(equalToConstant: 22),
        
        priceLabel.bottomAnchor.constraint(equalTo: cryptoPriceLabel.topAnchor, constant: -2),
        priceLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
        priceLabel.heightAnchor.constraint(equalToConstant: 18),
        
        deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16)
        ])
    }
}
