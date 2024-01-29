//
//  CurrencyTableViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 31.01.2024.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    static let identifier = "CurrencyTableViewCell"

    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    func configureCell(currency: Currency) {
        currencyNameLabel.text = currency.name

        setupSubviews()
        setupLayout()
    }
}
private extension CurrencyTableViewCell {
    func setupSubviews() {
        [currencyNameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            currencyNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currencyNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
