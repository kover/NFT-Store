//
//  DetailsViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import UIKit

class DetailsViewController: UIViewController {

    private let viewModel: DetailsViewModelProtocol

    private lazy var coverCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailsImageCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .ypWhite
        return collectionView
    }()

    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = viewModel.nft.name
        return label
    }()

    private lazy var ratingView: RatingView = {
        let rating = RatingView()
        rating.rating = viewModel.nft.rating
        return rating
    }()

    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = viewModel.collection.name
        return label
    }()

    private lazy var namesStackView: UIStackView = {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        spacer.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let stackView = UIStackView(arrangedSubviews: [nftNameLabel, ratingView, spacer, collectionNameLabel])
        stackView.spacing = 8
        return stackView
    }()

    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = NSLocalizedString("Details.price", comment: "Title for the price label")
        return label
    }()

    private lazy var priceTickerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "\(viewModel.nft.price) ETH"
        return label
    }()

    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Details.addToCart", comment: "Title for add to cart button"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.setTitleColor(.ypWhite, for: .normal)
        button.backgroundColor = .ypBlack
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()

    private lazy var cartStackView: UIStackView = {
        let priceStackView = UIStackView(arrangedSubviews: [priceTitleLabel, priceTickerLabel])
        priceStackView.axis = .vertical
        priceStackView.spacing = 2
        let stackView = UIStackView(arrangedSubviews: [priceStackView, cartButton])
        stackView.spacing = 28
        return stackView
    }()

    private lazy var contentController: DetailsContentViewController = {
        let contentController = DetailsContentViewController()

        addChild(contentController)

        view.addSubview(contentController.view)

        contentController.didMove(toParent: self)

        return contentController
    }()

    private lazy var pageControl = LinePageControl()

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ypWhite
        pageControl.numberOfItems = viewModel.nft.images.count

        setupSubviews()
        setupLayout()
    }

}
private extension DetailsViewController {
    func setupSubviews() {

        [coverCollectionView, pageControl, namesStackView, cartStackView, contentController.view].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            coverCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            coverCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            coverCollectionView.heightAnchor.constraint(equalTo: coverCollectionView.widthAnchor),

            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: coverCollectionView.bottomAnchor, constant: 12),

            namesStackView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
            namesStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            namesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            cartStackView.topAnchor.constraint(equalTo: namesStackView.bottomAnchor, constant: 24),
            cartStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            cartStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            contentController.view.topAnchor.constraint(equalTo: cartStackView.bottomAnchor, constant: 8),
            contentController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nft.images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailsImageCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)

        let item = viewModel.nft.images[indexPath.row]
        cell.setupCell(imageUrl: item)

        return cell
    }

}
// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let selectedItem = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.selectedItem = selectedItem
    }
}
