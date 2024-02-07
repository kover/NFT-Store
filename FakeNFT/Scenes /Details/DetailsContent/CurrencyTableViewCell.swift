//
//  CurrencyTableViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 31.01.2024.
//

import UIKit
import Kingfisher

final class CurrencyTableViewCell: UITableViewCell {
    static let identifier = "CurrencyTableViewCell"

    private lazy var currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = .ypBlackUniversal
        return imageView
    }()

    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .ypBlack
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .ypBlack
        label.text = "$18.11"
        return label
    }()

    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [currencyNameLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .ypGreenUniversal
        return label
    }()

    func configureCell(currency: Currency) {
        backgroundColor = .ypLightGray
        currencyNameLabel.text = "\(currency.title) (\(currency.id))"
        priceChangeLabel.text = "0.1 (\(currency.id))"

        let imageUrl = CurrencyConstants.urlFromString(string: currency.id)
        currencyImageView.kf.setImage(with: URL(string: imageUrl.rawValue))

        setupSubviews()
        setupLayout()
    }
}
// MARK: - Private routines
private extension CurrencyTableViewCell {
    func setupSubviews() {
        [currencyImageView, priceStack, priceChangeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            currencyImageView.widthAnchor.constraint(equalToConstant: 32),
            currencyImageView.heightAnchor.constraint(equalTo: currencyImageView.widthAnchor),
            currencyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currencyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            priceStack.heightAnchor.constraint(equalToConstant: 32),
            priceStack.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 10),
            priceStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            priceChangeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceChangeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: priceStack.trailingAnchor, constant: 16)
        ])
    }
}
