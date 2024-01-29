//
//  DetailsContentViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import UIKit

class DetailsContentViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        return collectionView
    }()

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
        0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsContentViewController: UICollectionViewDelegateFlowLayout {

}
