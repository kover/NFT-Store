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
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.dataSource = self
        table.delegate = self
        table.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        table.backgroundColor = .ypWhite
        table.separatorStyle = .none
        table.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: -36, right: 0)
        table.allowsSelection = false
        return table
    }()

    func configureCell(viewModel: DetailsContentViewModel) {
        setupSubviews()
        setupLayout()

        viewModel.$currencies.bind { [weak self] currencies in
            self?.currencies = currencies
            self?.tableView.reloadData()
        }
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
// MARK: - UITableViewDelegate
extension CurrenciesCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
}
