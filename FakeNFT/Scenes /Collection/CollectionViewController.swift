//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 22.01.2024.
//

import UIKit
import Kingfisher

final class CollectionViewController: UIViewController {

    private let viewModel: CollectionViewModel
    private var alertPresenter: AlertPresenterProtocol
    private let serviceAssembly: ServicesAssembly

    private lazy var collectionCoverImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.kf.indicatorType = .activity
        coverImageView.kf.setImage(with: URL(string: self.viewModel.collection.cover))
        coverImageView.layer.masksToBounds = true
        return coverImageView
    }()

    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .ypBlack
        label.text = self.viewModel.collection.name
        return label
    }()

    private lazy var authorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .ypBlack
        label.text = NSLocalizedString("Collection.author", comment: "Label for author name")
        return label
    }()

    private lazy var authorNameLabel: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.tintColor = .ypBlueUniversal
        button.setTitle(self.viewModel.collection.author, for: .normal)
        button.addTarget(self, action: #selector(showAuthorPage), for: .touchUpInside)
        return button
    }()

    private lazy var collectionDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.textColor = .ypBlack
        textView.backgroundColor = .ypWhite
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.text = self.viewModel.collection.description
        return textView
    }()

    private lazy var collectionNfts: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            NftCollectionViewCell.self,
            forCellWithReuseIdentifier: NftCollectionViewCell.nftCollectionViewCellIdentifier
        )
        collectionView.backgroundColor = .ypWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    init(
        viewModel: CollectionViewModel,
        alertPresenter: AlertPresenterProtocol,
        serviceAssembly: ServicesAssembly
    ) {
        self.viewModel = viewModel
        self.alertPresenter = alertPresenter
        self.serviceAssembly = serviceAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
        view.backgroundColor = .ypWhite
        navigationController?.navigationBar.tintColor = .black

        alertPresenter.delegate = self
        viewModel.alertPresenter = alertPresenter

        setupSubviews()
        setupLayout()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.loadOrder()
    }

    override func viewDidLayoutSubviews() {
        addCornerRadius()
    }
}
// MARK: - Private routines
extension CollectionViewController {
    func setupSubviews() {
        [
            collectionCoverImageView,
            collectionNameLabel,
            authorTitleLabel,
            authorNameLabel,
            collectionDescriptionTextView,
            collectionNfts
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            collectionCoverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionCoverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionCoverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionCoverImageView.heightAnchor.constraint(equalToConstant: 310),

            collectionNameLabel.topAnchor.constraint(equalTo: collectionCoverImageView.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            authorTitleLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 8),
            authorTitleLabel.leadingAnchor.constraint(equalTo: collectionNameLabel.leadingAnchor),
            authorTitleLabel.heightAnchor.constraint(equalToConstant: 28),

            authorNameLabel.topAnchor.constraint(equalTo: authorTitleLabel.topAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorTitleLabel.trailingAnchor, constant: 4),
            authorNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 28),

            collectionDescriptionTextView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor),
            collectionDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            collectionNfts.topAnchor.constraint(equalTo: collectionDescriptionTextView.bottomAnchor),
            collectionNfts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionNfts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionNfts.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func addCornerRadius() {
        let maskPath = UIBezierPath(
            roundedRect: collectionCoverImageView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 12, height: 12)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = collectionCoverImageView.bounds
        maskLayer.path = maskPath.cgPath
        collectionCoverImageView.layer.mask = maskLayer
    }

    func bind() {
        viewModel.$nfts.bind { [weak self] _ in
            self?.collectionNfts.reloadData()
        }

        viewModel.$profile.bind { [weak self] _ in
            self?.collectionNfts.reloadData()
        }

        viewModel.$order.bind { [weak self] _ in
            self?.collectionNfts.reloadData()
        }
    }

    @objc func showAuthorPage() {
        let authorPageViewController = AuthorPageViewController(url: ApiConstants.authorUrl.rawValue)
        navigationController?.pushViewController(authorPageViewController, animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nfts.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let nftCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NftCollectionViewCell.nftCollectionViewCellIdentifier,
            for: indexPath
        ) as? NftCollectionViewCell else {
            return NftCollectionViewCell()
        }

        let item = viewModel.nfts[indexPath.row]
        let isFavorite = viewModel.isLikeSet(for: item.id)
        let isInOrder = viewModel.isInOrder(item.id)
        nftCell.setupCell(with: item, isFavorite: isFavorite, isInOrder: isInOrder)
        nftCell.delegate = self

        return nftCell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 9 * 2 - 32) / 3, height: 192)
    }
}
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.nfts[indexPath.row]
        let detailViewModel = DetailsViewModel(nft: item,
                                               collection: viewModel.collection,
                                               serviceAssembly: serviceAssembly,
                                               alertPresenter: alertPresenter
        )
        let detailViewController = DetailsViewController(viewModel: detailViewModel,
                                                         serviceAssembly: serviceAssembly,
                                                         alertPresenter: alertPresenter)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
// MARK: - NftCollectionViewCellDelegate
extension CollectionViewController: NftCollectionViewCellDelegate {
    func didTapCart(_ item: NftItem) {
        viewModel.toggleOrder(for: item.id)
    }

    func didTapLike(_ item: NftItem) {
        viewModel.toggleLike(for: item.id)
    }

}
