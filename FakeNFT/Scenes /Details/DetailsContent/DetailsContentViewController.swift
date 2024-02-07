//
//  DetailsContentViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import UIKit

final class DetailsContentViewController: UIViewController {

    var authorPageDelegate: AuthorPageCollectionViewCellProtocol?

    private let viewModel: DetailsContentViewModel

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 36, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .ypWhite
        collectionView.register(CurrenciesCollectionViewCell.self)
        collectionView.register(AuthorPageCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    init(viewModel: DetailsContentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupLayout()
    }

}
// MARK: - Private routines
private extension DetailsContentViewController {
    private func setupSubviews() {
        [collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
// MARK: - UICollectionViewDataSource
extension DetailsContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let currenciesCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrenciesCollectionViewCell.defaultReuseIdentifier,
                for: indexPath) as? CurrenciesCollectionViewCell else {
                return UICollectionViewCell()
            }
            currenciesCell.configureCell(viewModel: viewModel)
            return currenciesCell
        case 1:
            guard let authorPageCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AuthorPageCollectionViewCell.defaultReuseIdentifier,
                for: indexPath) as? AuthorPageCollectionViewCell else {
                return UICollectionViewCell()
            }
            authorPageCell.configureCell()
            authorPageCell.delegate = authorPageDelegate
            return authorPageCell
        default:
            return UICollectionViewCell()
        }
    }

}
// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 72 * 5)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 40)
        default:
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
}
