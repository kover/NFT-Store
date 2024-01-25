//
//  FavoritesNTFViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 25.01.2024.
//

import UIKit

class FavoritesNTFViewController: UIViewController {

    //Mocked models
    private var NTFList = [
        MyNTFScreenModel(title: "Archie", artwork: UIImage(named: "NTF1") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 3, isFavorite: false),
        MyNTFScreenModel(title: "Spring", artwork: UIImage(named: "NTF2") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 4, isFavorite: true),
        MyNTFScreenModel(title: "Spring", artwork: UIImage(named: "NTF2") ?? UIImage(), author: "John Doe", price: "1,78", currency: "ETH", rating: 4, isFavorite: true)
    ]
    
    private var NTFCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNTFCollection()
        configureLayout()
    }
    
    private func configureNTFCollection() {
        NTFCollection.dataSource = self
        NTFCollection.delegate = self
        NTFCollection.register(FavoritesNTFCell.self, forCellWithReuseIdentifier: FavoritesNTFCell.identifier)
    }
        
    @objc
    private func onBackButtonClick() {
        dismiss(animated: true)
    }
    
    @objc
    private func onSortButtonClick() {
        
    }
}

//MARK: - UICollectionViewDataSource
extension FavoritesNTFViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        NTFList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesNTFCell.identifier, for: indexPath) as? FavoritesNTFCell else { return UICollectionViewCell() }
        
        cell.setModel(NTFList[indexPath.item])
        
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
        
        let backButtonImage = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .default)
        )
        let backButton = UIButton.systemButton(
            with: backButtonImage ?? UIImage(),
            target: nil,
            action: #selector(onBackButtonClick)
        )
        backButton.tintColor = .ypBlack
        backButton.backgroundColor = .clear
        
        view.addSubView(
            backButton, width: Property.backButtonWidth, heigth: Property.backButtonWidth,
            top: AnchorOf(view.topAnchor, 52),
            leading: AnchorOf(view.leadingAnchor, 8)
        )
        
        let screenTitle = UILabel()
        screenTitle.textColor = .ypBlack
        screenTitle.backgroundColor = .clear
        screenTitle.font = UIFont.boldSystemFont(ofSize: 17)
        screenTitle.text = localized("Profile.favoritesNTF")
        
        view.addSubView(
            screenTitle,
            centerX: AnchorOf(view.centerXAnchor),
            centerY: AnchorOf(backButton.centerYAnchor)
        )
        
        NTFCollection.backgroundColor = .clear
        view.addSubView(
            NTFCollection,
            top: AnchorOf(screenTitle.bottomAnchor, 46),
            bottom: AnchorOf(view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
    }
}
