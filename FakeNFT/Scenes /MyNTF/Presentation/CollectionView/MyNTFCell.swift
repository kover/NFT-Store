//
//  MyNTFCell.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit
import Kingfisher

final class MyNTFCell: UICollectionViewCell {
    
    static let identifier = "MyNTFCell"
    
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
    
    private let author: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .ypBlack
        return label
    }()
    
    private let priceSectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .ypBlack
        label.text = localized("Price")
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
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
    
    private let ratingPanel: UIStarRatingPanel = {
        let starRatingPanel = UIStarRatingPanel(starsCount: 5)
        starRatingPanel.starSpacing = 2
        starRatingPanel.activeColor = .ypYellow
        starRatingPanel.inactiveColor = .ypLigthGrey
        starRatingPanel.symbolConfiguration =
            UIImage.SymbolConfiguration(pointSize: 11, weight: .regular, scale: .default)
        return starRatingPanel
    }()
    
    private var isFavorite = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: MyNTFScreenModel) {
        title.text = model.title
        author.text = "\(localized("From")) \(model.author)"
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
            artwork, width: 108, heigth: 108,
            top: AnchorOf(contentView.topAnchor),
            leading: AnchorOf(contentView.leadingAnchor)
        )
        
        contentView.addSubView(
            title,
            top: AnchorOf(contentView.topAnchor, 24),
            leading: AnchorOf(artwork.trailingAnchor, 20)
        )
                
        contentView.addSubView(
            ratingPanel, heigth: 12,
            top: AnchorOf(title.bottomAnchor, 4),
            leading: AnchorOf(title.leadingAnchor)
        )
        
        contentView.addSubView(
            author,
            top: AnchorOf(ratingPanel.bottomAnchor, 4),
            leading: AnchorOf(title.leadingAnchor)
        )
                
        contentView.addSubView(
            priceSectionTitle,
            leading: AnchorOf(artwork.trailingAnchor, 140),
            centerY: AnchorOf(ratingPanel.centerYAnchor, -8)
        )
                
        contentView.addSubView(
            price,
            top: AnchorOf(priceSectionTitle.bottomAnchor, 2),
            leading: AnchorOf(priceSectionTitle.leadingAnchor)
        )
                
        contentView.addSubView(
            favoriteButton, width: 42, heigth: 42,
            top: AnchorOf(artwork.topAnchor),
            trailing: AnchorOf(artwork.trailingAnchor)
        )
    }
}
