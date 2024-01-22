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

    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .ypBlueUniversal
        label.text = self.viewModel.collection.author
        return label
    }()

    private lazy var collectionDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.textColor = .ypBlack
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.text = self.viewModel.collection.description
        return textView
    }()

    private lazy var collectionNfts: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ypWhite
        navigationController?.navigationBar.tintColor = .black

        setupSubviews()
        setupLayout()
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

            collectionNfts.topAnchor.constraint(equalTo: collectionDescriptionTextView.bottomAnchor, constant: 24),
            collectionNfts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionNfts.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
}
