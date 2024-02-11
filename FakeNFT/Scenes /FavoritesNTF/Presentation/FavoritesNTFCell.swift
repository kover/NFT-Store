//
//  FavoritesNTFCell.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import UIKit
import Kingfisher

final class FavoritesNTFCell: UICollectionViewCell {
    
    static let identifier = "FavoritesCell"
    
    private var delegate: NTFCellDelegate?
    
    private var indexPath: IndexPath?
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .ypBlack
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let artwork: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.backgroundColor = .ypLightGray
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .ypBlack
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "heart.fill") ?? UIImage(),
            target: nil,
            action: #selector(favoriteButtonClick)
        )
        button.isHidden = true
        return button
    }()
    
    private var isFavorite = false
    
    private let ratingPanel: UIStarRatingPanel = {
        let starRatingPanel = UIStarRatingPanel(starsCount: 5)
        starRatingPanel.starSpacing = 3
        starRatingPanel.activeColor = .ypYellowUniversal
        starRatingPanel.inactiveColor = .ypLightGray
        starRatingPanel.symbolConfiguration =
        UIImage.SymbolConfiguration(pointSize: 11, weight: .regular, scale: .default)
        return starRatingPanel
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .medium
        return activityIndicatorView
    }()
    
    private let errorLoadingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = localized("Error.loading_false")
        label.numberOfLines = 4
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "goforward") ?? UIImage(),
            target: nil,
            action: #selector(refreshButtonClick)
        )
        button.tintColor = .gray
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: FavoritesNTFScreenModel?) {
        guard let model else {
            updateLoadingStatus(isLoading: true)
            return
        }
        updateLoadingStatus(isLoading: false)
        
        title.text = model.title
        price.text = model.price + " " + model.currency
        isFavorite = model.isFavorite
        
        favoriteButton.isHidden = false
        favoriteButton.tintColor = isFavorite ? .ypRedUniversal : .ypWhiteUniversal
        
        ratingPanel.setRating(model.rating)
        
        artwork.backgroundColor = .clear
        updateArtwork(for: model.artworkUrl)
    }
    
    func setDelegate(_ delegate: NTFCellDelegate) {
        self.delegate = delegate
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func loadingErrorState(isError: Bool) {
        updateLoadingStatus(isLoading: false)
        refreshButton.isHidden = !isError
        errorLoadingLabel.isHidden = !isError
    }
    
    @objc
    private func favoriteButtonClick() {
        guard let indexPath else { return }
        delegate?.onFavoriteStatusChanged(with: indexPath)
        
        isFavorite = !isFavorite
        favoriteButton.tintColor = isFavorite ? .ypRedUniversal : .ypWhiteUniversal
    }
    
    @objc
    private func refreshButtonClick() {
        guard let indexPath else { return }
        delegate?.onRefresh(with: indexPath)
        loadingErrorState(isError: false)
        updateLoadingStatus(isLoading: true)
    }
    
    private func updateArtwork(for url: URL?) {
        artwork.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "scribble.variable")
        )
    }
    
    private func updateLoadingStatus(isLoading: Bool) {
        contentView.isUserInteractionEnabled = !isLoading
        activityIndicator.isHidden = !isLoading
        artwork.backgroundColor = .ypLightGray
        
        let animation: () -> Void = isLoading ? { self.activityIndicator.startAnimating() } : { self.activityIndicator.stopAnimating() }
        animation()
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
            leading: AnchorOf(artwork.trailingAnchor, 12),
            trailing: AnchorOf(contentView.trailingAnchor)
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
        
        contentView.addSubView(
            activityIndicator,
            centerX: AnchorOf(artwork.centerXAnchor),
            centerY: AnchorOf(artwork.centerYAnchor)
        )
        
        contentView.addSubView(
            errorLoadingLabel,
            top: AnchorOf(artwork.topAnchor, 10),
            leading: AnchorOf(artwork.leadingAnchor, 2),
            trailing: AnchorOf(artwork.trailingAnchor, -2)
        )
        
        contentView.addSubView(
            refreshButton,
            centerX: AnchorOf(artwork.centerXAnchor),
            centerY: AnchorOf(artwork.centerYAnchor, 10)
        )
    }
}
