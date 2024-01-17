//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 18.01.2024.
//

import UIKit
import Kingfisher

class CatalogTableViewCell: UITableViewCell {
    
    static let catalogTableViewCellIdentifier = "catalogTableViewCell"
    
    private lazy var coverImageView: UIImageView = {
        let imageview = UIImageView(frame: .zero)
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 12
        imageview.contentMode = .scaleAspectFill
        
        return imageview
    }()
    
    private lazy var collectionNameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        return nameLabel
    }()
    
    private lazy var nftsCountLabel: UILabel = {
        let countLabel = UILabel()
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        return countLabel
    }()
    
    // MARK: - Cell configuration
    func setupCell(for collection: CatalogCell, completion: @escaping () -> Void) {
        coverImageView.kf.indicatorType = .activity
        coverImageView.kf.setImage(
            with: URL(string: collection.cover),
            placeholder: UIImage(named: "Stub")
        ) { _ in
            completion()
        }
        
        collectionNameLabel.text = collection.name
        nftsCountLabel.text = "(\(collection.nftsCount))"
        
        setupSubviews()
        setupLayout()
    }

}
// MARK: - Layout configuration
private extension CatalogTableViewCell {
    func setupSubviews() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(collectionNameLabel)
        contentView.addSubview(nftsCountLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            coverImageView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionNameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 4),
            collectionNameLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            
            nftsCountLabel.topAnchor.constraint(equalTo: collectionNameLabel.topAnchor),
            nftsCountLabel.leadingAnchor.constraint(equalTo: collectionNameLabel.trailingAnchor, constant: 4)
        ])
    }
}
