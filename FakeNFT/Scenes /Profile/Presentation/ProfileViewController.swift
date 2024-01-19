//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 17.01.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let userAvatar = UIImageView()
    
    private let userName = UILabel()
    
    private let userDescription = UILabel()
    
    private let userLink = UILabel()
    
    private let ownNFTSection = ProfileFunctionalSection()
    
    private let favoriteNTFSection = ProfileFunctionalSection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    @objc
    private func editProfileButtonClick() {
        
    }
    
    private func myNTFSectionClick() {
        
    }
    
    private func favoritesNTFSectionClick() {
        
    }
    
    private func developerDescriptionClick() {
        
    }
    
    private func updateOwnNTFCount(_ count: Int?) {
        
    }
    
    private func updateFavoritesNTFCount(_ count: Int?) {
        
    }
}

//Configure layout
extension ProfileViewController {
    
    private struct Dimension {
        static let commonMargin: CGFloat = 16
        static let avatarDiameter: CGFloat = 70
        static let functionalSectionHeigth: CGFloat = 56
    }
    
    private func configureLayout() {
        let editProfileButton = UIButton.systemButton(
            with: UIImage(systemName: "square.and.pencil") ?? UIImage(),
            target: nil,
            action: #selector(editProfileButtonClick)
        )
        editProfileButton.tintColor = .ypBlack
        editProfileButton.backgroundColor = .clear
        
        editProfileButton.contentVerticalAlignment = .fill
        editProfileButton.contentHorizontalAlignment = .fill
        editProfileButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        view.addSubView(
            editProfileButton, width: 42, heigth: 42,
            top: AnchorOf(view.topAnchor, 52),
            trailing: AnchorOf(view.trailingAnchor, -16)
        )
        
        userAvatar.image = UIImage(systemName: "person.circle.fill")
        userAvatar.tintColor = .ypBlack
        userAvatar.contentMode = .scaleAspectFill
        
        view.addSubView(
            userAvatar, width: Dimension.avatarDiameter, heigth: Dimension.avatarDiameter,
            top: AnchorOf(editProfileButton.bottomAnchor, 20),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin)
        )
        
        userName.textColor = .ypBlack
        userName.font = UIFont.boldSystemFont(ofSize: 22)
        userName.textAlignment = .left
        userName.numberOfLines = 1
        userName.lineBreakMode = .byTruncatingTail
        
        //temporarily mocked user's name
        userName.text = "Joaquin Phoenix"
        
        view.addSubView(
            userName,
            leading: AnchorOf(userAvatar.trailingAnchor, 16),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin),
            centerY: AnchorOf(userAvatar.centerYAnchor)
        )
        
        userDescription.textColor = .ypBlack
        userDescription.font = UIFont.systemFont(ofSize: 13)
        userDescription.textAlignment = .left
        userDescription.lineBreakMode = .byWordWrapping
        userDescription.numberOfLines = 0
        
        //temporarily mocked user's description
        userDescription.text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
       
        view.addSubView(
            userDescription,
            top: AnchorOf(userAvatar.bottomAnchor, 20),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        
        userLink.textColor = .ypBlue
        userLink.font = UIFont.systemFont(ofSize: 15)
        userLink.textAlignment = .left
        userLink.numberOfLines = 1
        userLink.lineBreakMode = .byTruncatingTail
        
        //temporarily mocked user's link
        userLink.text = "Joaquin Phoenix.com"
        
        view.addSubView(
            userLink,
            top: AnchorOf(userDescription.bottomAnchor, 12),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        
        view.addSubView(
            ownNFTSection.view, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(userLink.bottomAnchor, 40),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        ownNFTSection.setup()
        ownNFTSection.setContentTitle(localized("Profile.myNTF"))
        ownNFTSection.setAction { self.myNTFSectionClick() }
        
        view.addSubView(
            favoriteNTFSection.view, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(ownNFTSection.view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        favoriteNTFSection.setup()
        favoriteNTFSection.setContentTitle(localized("Profile.favoritesNTF"))
        favoriteNTFSection.setAction { self.favoritesNTFSectionClick() }
        
        let developerDescription = ProfileFunctionalSection()
        view.addSubView(
            developerDescription.view, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(favoriteNTFSection.view.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        developerDescription.setup()
        developerDescription.setContentTitle(localized("Profile.aboutDeveloper"))
        developerDescription.setAction { self.developerDescriptionClick() }
    }
}
