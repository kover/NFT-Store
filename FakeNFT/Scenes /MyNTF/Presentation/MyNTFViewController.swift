//
//  MyNTFViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 21.01.2024.
//

import UIKit

final class MyNTFViewController: UIViewController {

    private let viewModel: MyNTFViewModelProtocol
    
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
        label.text = localized("Profile.myNTF")
        return label
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton.systemButton(
        with: UIImage(named: "Sort") ?? UIImage(),
        target: nil,
        action: #selector(onSortButtonClick)
    )
        button.tintColor = .ypBlack
        button.backgroundColor = .clear
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = localized("Profile.NTFs.Placeholder")
        label.textAlignment = .center
        label.isHidden = true
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

    init(viewModel: MyNTFViewModelProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidApear()
    }
    
    private func configureNTFCollection() {
        ntfCollection.collectionViewLayout = configureNTFCollectionFlowLayout()
        ntfCollection.dataSource = self
        ntfCollection.register(MyNTFCell.self, forCellWithReuseIdentifier: MyNTFCell.identifier)
    }
    
    private func setObservers() {
        viewModel.observeUpdateNTFModel { [weak self] indexPath in
            guard let self else { return }
            self.updateNTFCollectionCell(for: indexPath)
        }
        viewModel.observeUpdateNTFCollection { [weak self] in
            guard let self else { return }
            self.ntfCollection.reloadData()
        }
        viewModel.observeUpdatedPlaceholderState { [weak self] isPlaceholder in
            guard let self else { return }
            self.updatePlaceholderState(isPlaceholder: isPlaceholder)
        }
    }
    
    private func updatePlaceholderState(isPlaceholder: Bool) {
            screenTitle.isHidden = isPlaceholder
            sortButton.isHidden = isPlaceholder
            ntfCollection.isHidden = isPlaceholder
            placeholderLabel.isHidden = !isPlaceholder
        }
    
    private func updateNTFCollectionCell(for indexPath: IndexPath) {
        guard let cell = ntfCollection.cellForItem(at: indexPath) as? MyNTFCell else { return }
        
        guard let ntf = viewModel.object(for: indexPath) else {
            cell.loadingErrorState(isError: true)
            return
        }
        cell.setModel(ntf)
    }
        
    @objc
    private func onBackButtonClick() {
        dismiss(animated: true)
    }
    
    @objc
    private func onSortButtonClick() {
        let actions = [
            AlertAction(title: localized("Sorting.byPrice")) {[weak self] in
                guard let self else { return }
                viewModel.sortNTFs(.byPrice)
            },
            AlertAction(title: localized("Sorting.byRating")) {[weak self] in
                guard let self else { return }
                viewModel.sortNTFs(.byRating)
            },
            AlertAction(title: localized("Sorting.byTitle")) {[weak self] in
                guard let self else { return }
                viewModel.sortNTFs(.byTitle)
            }
        ]
        AlertController.multiAction(
            alertPresenter: self, title: localized("Sorting"), actions: actions
        )
    }
}

//MARK: - UICollectionViewDataSource
extension MyNTFViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.itemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: MyNTFCell.identifier, for: indexPath) as? MyNTFCell else { return UICollectionViewCell() }
        
        cell.setModel(viewModel.object(for: indexPath))
        cell.setIndexPath(indexPath)
        cell.setDelegate(self)
        
        return cell
    }
}

//MARK: - FavoritesNTFCellDelegate
extension MyNTFViewController: NTFCellDelegate {
    func onFavoriteStatusChanged(with indexPath: IndexPath ) {
        viewModel.changeFavoriteNTFStatus(for: indexPath)
    }
    
    func onRefresh(with indexPath: IndexPath) {
        viewModel.refreshObject(for: indexPath)
    }
}

//MARK: - AlertPresenter Protocol
extension MyNTFViewController: AlertPresenterProtocol {
    func present(alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated)
    }
}

//MARK: - Configure layout
extension MyNTFViewController {
    
    private struct Property {
        static let commonMargin: CGFloat = 16
        static let backButtonWidth: CGFloat = 24
        static let sortButtonWidth: CGFloat = 42
    }
    
    private func configureNTFCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width - Property.commonMargin * 2, height: 108)
        layout.minimumLineSpacing = 32
        return layout
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
            sortButton, width: Property.sortButtonWidth, heigth: Property.sortButtonWidth,
            trailing: AnchorOf(view.trailingAnchor, -8),
            centerY: AnchorOf(screenTitle.centerYAnchor)
        )
        
        view.addSubView(
            ntfCollection,
            top: AnchorOf(screenTitle.bottomAnchor, 46),
            bottom: AnchorOf(view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        view.addSubView(
            placeholderLabel,
            leading: AnchorOf(view.leadingAnchor),
            trailing: AnchorOf(view.trailingAnchor),
            centerY: AnchorOf(view.centerYAnchor)
        )
    }
}
