//
//  CurrencyCollectionViewCell.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 28.01.2024.
//

import UIKit

final class CurrencyCollectionViewCell: UICollectionViewCell {
    
    private lazy var currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.ypBlackUniversal
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.ypGreenUniversal
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with cellModel: CurrencyModel) {
        contentView.backgroundColor = UIColor.ypLightGray
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        currencyImageView.kf.setImage(with: URL(string: cellModel.imageURL))
        currencyImageView.layer.cornerRadius = 6
        titleLabel.text = cellModel.title
        nameLabel.text = cellModel.name
        
        addSubviews()
        setupConstraints()
    }
    
    
    private func addSubviews() {
        contentView.addSubview(currencyImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            currencyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            currencyImageView.widthAnchor.constraint(equalToConstant: 36),
            currencyImageView.heightAnchor.constraint(equalToConstant: 36),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 4),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
}
