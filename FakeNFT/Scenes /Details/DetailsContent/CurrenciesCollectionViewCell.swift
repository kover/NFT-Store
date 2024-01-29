//
//  CurrenciesCollectionViewCell.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 30.01.2024.
//

import UIKit

final class CurrenciesCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    private var currencies: [Currency] = []

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        return table
    }()

    func configureCell(currencies: [Currency]) {
        setupSubviews()
        setupLayout()

        self.currencies = currencies
    }
}
// MARK: - Private routines
private extension CurrenciesCollectionViewCell {
    func setupSubviews() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate
extension CurrenciesCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier,
                                                       for: indexPath) as? CurrencyTableViewCell else {
            return CurrencyTableViewCell()
        }

        let item = currencies[indexPath.row]
        cell.configureCell(currency: item)
        return cell
    }

}
