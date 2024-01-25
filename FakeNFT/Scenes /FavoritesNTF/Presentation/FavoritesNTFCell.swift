//
//  FavoritesNTFCell.swift
//  FakeNFT
//
//  Created by Avtor_103 on 25.01.2024.
//

import UIKit

class FavoritesNTFCell: UICollectionViewCell {
    
    static let identifier = "FavoritesCell"
    
    private let title = UILabel()
    
    private let artwork = UIImageView()
    
    private let price = UILabel()
    
    private var favoriteButton: UIButton!
    
    private var isFavorite = false
    
    private let ratingPanel = StarRatingPanel(starsCount: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: MyNTFScreenModel) {
        title.text = model.title
        artwork.image = model.artwork
        price.text = model.price + " " + model.currency
        isFavorite = model.isFavorite
        favoriteButton.tintColor = isFavorite ? .ypRed : .ypWhiteUniversal
        ratingPanel.setRating(model.rating)
    }
    
    @objc
    private func favoriteButtonClick() {
        isFavorite = !isFavorite
        favoriteButton.tintColor = isFavorite ? .ypRed : .ypWhiteUniversal
    }
    
    private func configureCell() {
        contentView.backgroundColor = .clear
        
        artwork.layer.cornerRadius = 12
        artwork.contentMode = .scaleAspectFill
        artwork.clipsToBounds = true
        
        contentView.addSubView(
            artwork, width: 80, heigth: 80,
            top: AnchorOf(contentView.topAnchor),
            leading: AnchorOf(contentView.leadingAnchor)
        )
        
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.textColor = .ypBlack
        
        contentView.addSubView(
            title,
            top: AnchorOf(contentView.topAnchor, 8),
            leading: AnchorOf(artwork.trailingAnchor, 12)
        )
        
        ratingPanel.starSpacing = 2
        ratingPanel.activeColor = .ypYellow
        ratingPanel.inactiveColor = .ypLigthGrey
        ratingPanel.symbolConfiguration =
            UIImage.SymbolConfiguration(pointSize: 11, weight: .regular, scale: .default)
        ratingPanel.setup()
        
        contentView.addSubView(
            ratingPanel.view, heigth: 12,
            top: AnchorOf(title.bottomAnchor, 4),
            leading: AnchorOf(title.leadingAnchor)
        )
        
        price.font = UIFont.systemFont(ofSize: 15)
        price.textColor = .ypBlack
        
        contentView.addSubView(
            price,
            top: AnchorOf(ratingPanel.view.bottomAnchor, 8),
            leading: AnchorOf(title.leadingAnchor)
        )
        
        favoriteButton = UIButton.systemButton(
            with: UIImage(systemName: "heart.fill") ?? UIImage(),
            target: nil,
            action: #selector(favoriteButtonClick)
        )
        
        contentView.addSubView(
            favoriteButton, width: 42, heigth: 42,
            top: AnchorOf(artwork.topAnchor),
            trailing: AnchorOf(artwork.trailingAnchor)
        )
    }
}
