//
//  AuthorPageCollectionViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 31.01.2024.
//

import UIKit

final class AuthorPageCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    private lazy var authorPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Details.sellerPage", comment: "Title for the seller page button"),
                        for: .normal)
        button.tintColor = .ypBlack
        button.setTitleColor(.ypBlack, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        return button
    }()

    func configureCell() {
        setupSubviews()
        setupLayout()
    }
}
private extension AuthorPageCollectionViewCell {
    func setupSubviews() {
        [authorPageButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            authorPageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorPageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorPageButton.heightAnchor.constraint(equalToConstant: 40),
            authorPageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
