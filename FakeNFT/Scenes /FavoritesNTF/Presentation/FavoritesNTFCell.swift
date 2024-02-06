//
//  FavoritesNTFCell.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import UIKit

final class FavoritesNTFCell: UICollectionViewCell {
    
    static let identifier = "FavoritesCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .ypBlack
        return label
    }()
    
    private let artwork: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .ypBlack
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "heart.fill") ?? UIImage(),
            target: nil,
            action: #selector(favoriteButtonClick)
        )
        return button
    }()
    
    private var isFavorite = false
    
    private let ratingPanel: UIStarRatingPanel = {
        let starRatingPanel = UIStarRatingPanel(starsCount: 5)
        starRatingPanel.starSpacing = 2
        starRatingPanel.activeColor = .ypYellow
        starRatingPanel.inactiveColor = .ypLigthGrey
        starRatingPanel.symbolConfiguration =
        UIImage.SymbolConfiguration(pointSize: 11, weight: .regular, scale: .default)
        return starRatingPanel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: FavoritesNTFScreenModel) {
        title.text = model.title
        price.text = model.price + " " + model.currency
        isFavorite = model.isFavorite
        favoriteButton.tintColor = isFavorite ? .ypRed : .ypWhiteUniversal
        ratingPanel.setRating(model.rating)
        
        updateArtwork(for: model.artworkUrl)
    }
    
    @objc
    private func favoriteButtonClick() {
        isFavorite = !isFavorite
        favoriteButton.tintColor = isFavorite ? .ypRed : .ypWhiteUniversal
    }
    
    private func updateArtwork(for url: URL?) {
        artwork.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "scribble.variable")
        )
    }
    
    private func configureCell() {
        contentView.backgroundColor = .clear
        
        contentView.addSubView(
            artwork, width: 80, heigth: 80,
            top: AnchorOf(contentView.topAnchor),
            leading: AnchorOf(contentView.leadingAnchor)
        )
        
        contentView.addSubView(
            title,
            top: AnchorOf(contentView.topAnchor, 8),
            leading: AnchorOf(artwork.trailingAnchor, 12)
        )
        
        contentView.addSubView(
            ratingPanel, heigth: 12,
            top: AnchorOf(title.bottomAnchor, 4),
            leading: AnchorOf(title.leadingAnchor)
        )
        
        contentView.addSubView(
            price,
            top: AnchorOf(ratingPanel.bottomAnchor, 8),
            leading: AnchorOf(title.leadingAnchor)
        )
        
        contentView.addSubView(
            favoriteButton, width: 30, heigth: 30,
            top: AnchorOf(artwork.topAnchor),
            trailing: AnchorOf(artwork.trailingAnchor)
        )
    }
}
