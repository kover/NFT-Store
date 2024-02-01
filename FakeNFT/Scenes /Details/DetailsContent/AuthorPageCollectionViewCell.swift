//
//  AuthorPageCollectionViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 31.01.2024.
//

import UIKit

protocol AuthorPageCollectionViewCellProtocol: AnyObject {
    func showAuthorPage()
}

final class AuthorPageCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    var delegate: AuthorPageCollectionViewCellProtocol?

    private var dynamicColor: CGColor {
        return UIColor.ypBlack.cgColor
    }

    private lazy var authorPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Details.sellerPage", comment: "Title for the seller page button"),
                        for: .normal)
        button.tintColor = .ypBlack
        button.setTitleColor(.ypBlack, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = dynamicColor
        button.addTarget(self, action: #selector(showAuthorPage), for: .touchUpInside)
        return button
    }()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        authorPageButton.layer.borderColor = dynamicColor
    }

    func configureCell() {
        setupSubviews()
        setupLayout()
    }

    @objc func showAuthorPage() {
        delegate?.showAuthorPage()
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
