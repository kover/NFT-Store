//
//  FavoritesNTFViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import UIKit

final class FavoritesNTFViewController: UIViewController {

    private let viewModel: FavoritesNTFViewModelProtocol
    
    private let backButton: UIButton = {
        let backButtonImage = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .default)
        )
        let button = UIButton.systemButton(
            with: backButtonImage ?? UIImage(),
            target: nil,
            action: #selector(onBackButtonClick)
        )
        button.tintColor = .ypBlack
        button.backgroundColor = .clear
        return button
    }()
    
    private let screenTitle: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = localized("Profile.favoritesNTF")
        return label
    }()
    
    private let ntfCollection: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var onFavoritesNTFsChanged: ( ([String]) -> Void )?

    init(viewModel: FavoritesNTFViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNTFCollection()
        configureLayout()
        setObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onFavoritesNTFsChanged?(viewModel.getUpdatedFavoritesNTFsIds())
    }
    
    func onFavoritesNTFsChanged(_ completion: @escaping ([String]) -> Void) {
        self.onFavoritesNTFsChanged = completion
    }
    
    private func configureNTFCollection() {
        ntfCollection.dataSource = self
        ntfCollection.delegate = self
        ntfCollection.register(FavoritesNTFCell.self, forCellWithReuseIdentifier: FavoritesNTFCell.identifier)
    }
    
    private func setObservers() {
        viewModel.observeUpdateNTFModel { [weak self] indexPath in
            guard let self else { return }
            self.updateNTFCollectionCell(for: indexPath)
        }
    }
    
    private func updateNTFCollectionCell(for indexPath: IndexPath) {
        guard let cell = ntfCollection.cellForItem(at: indexPath) as? FavoritesNTFCell else { return }
        
        guard let ntfModel = viewModel.object(for: indexPath) else {
            cell.loadingErrorState(isError: true)
            return
        }
        cell.setModel(ntfModel)
    }
            
    @objc
    private func onBackButtonClick() {
        dismiss(animated: true)
    }
}

//MARK: - FavoritesNTFCellDelegate
extension FavoritesNTFViewController: FavoritesNTFCellDelegate {
    func onFavoriteStatusChanged(with indexPath: IndexPath ) {
        viewModel.changeFavoriteNTFStatus(for: indexPath)
    }
    
    func onRefresh(with indexPath: IndexPath) {
        viewModel.refreshObject(for: indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesNTFViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.itemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesNTFCell.identifier, for: indexPath) as? FavoritesNTFCell else { return UICollectionViewCell() }
    
        cell.setModel(
            viewModel.object(for: indexPath)
        )
        cell.setIndexPath(indexPath)
        cell.setDelegate(self)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesNTFViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 4, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int)
    -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }
}

//MARK: - Configure layout
extension FavoritesNTFViewController {
    
    private struct Property {
        static let commonMargin: CGFloat = 16
        static let backButtonWidth: CGFloat = 24
    }
    
    private func configureLayout() {
        view.backgroundColor = .ypWhite
                
        view.addSubView(
            backButton, width: Property.backButtonWidth, heigth: Property.backButtonWidth,
            top: AnchorOf(view.safeAreaLayoutGuide.topAnchor, 8),
            leading: AnchorOf(view.leadingAnchor, 8)
        )
                
        view.addSubView(
            screenTitle,
            centerX: AnchorOf(view.centerXAnchor),
            centerY: AnchorOf(backButton.centerYAnchor)
        )
        
        view.addSubView(
            ntfCollection,
            top: AnchorOf(screenTitle.bottomAnchor, 46),
            bottom: AnchorOf(view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
    }
}
