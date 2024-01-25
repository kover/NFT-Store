//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 18.01.2024.
//

import UIKit
import Kingfisher

final class CatalogTableViewCell: UITableViewCell {

    static let catalogTableViewCellIdentifier = "catalogTableViewCell"

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)

        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var collectionNameLabel: UILabel = {
        let nameLabel = UILabel()

        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.textColor = .ypBlack

        return nameLabel
    }()

    private lazy var nftsCountLabel: UILabel = {
        let countLabel = UILabel()

        countLabel.font = .systemFont(ofSize: 17, weight: .bold)
        countLabel.textColor = .ypBlack

        return countLabel
    }()

    // MARK: - Cell configuration
    func setupCell(for collection: NftCollection) {
        selectionStyle = .none
        contentView.backgroundColor = .ypWhite

        coverImageView.kf.indicatorType = .activity
        coverImageView.kf.setImage(
            with: URL(string: collection.cover),
            placeholder: UIImage(named: "Stub")
        ) {_ in }

        collectionNameLabel.text = collection.name
        nftsCountLabel.text = "(\(collection.nfts.count))"

        setupSubviews()
        setupLayout()
    }

}
// MARK: - Layout configuration
private extension CatalogTableViewCell {
    func setupSubviews() {
        [coverImageView, collectionNameLabel, nftsCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
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
