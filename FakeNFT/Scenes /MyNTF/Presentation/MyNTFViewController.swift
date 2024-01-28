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
    
    private let NTFCollection: UICollectionView = {
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
    }
    
    private func configureNTFCollection() {
        NTFCollection.collectionViewLayout = configureNTFCollectionFlowLayout()
        NTFCollection.dataSource = self
        NTFCollection.register(MyNTFCell.self, forCellWithReuseIdentifier: MyNTFCell.identifier)
    }
        
    @objc
    private func onBackButtonClick() {
        dismiss(animated: true)
    }
    
    @objc
    private func onSortButtonClick() {
        //TODO sort NTF items
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
        
        if let model = viewModel.object(for: indexPath) {
            cell.setModel(model)
        }
        return cell
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
            NTFCollection,
            top: AnchorOf(screenTitle.bottomAnchor, 46),
            bottom: AnchorOf(view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
    }
}
