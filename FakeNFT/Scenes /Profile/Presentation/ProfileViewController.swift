//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 17.01.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModelProtocol
    
    private let editProfileButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "square.and.pencil") ?? UIImage(),
            target: nil,
            action: #selector(editProfileButtonClick)
        )
        button.tintColor = .ypBlack
        button.backgroundColor = .clear
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    private let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .ypBlack
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Dimension.avatarDiameter/2
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let userDescription: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let userLink: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let myNFTSection =
        UIProfileFunctionalSection(title: localized("Profile.myNTF"))
 
    private let favoriteNTFSection =
        UIProfileFunctionalSection(title: localized("Profile.favoritesNTF"))
    
    private let developerSection =
        UIProfileFunctionalSection(title: localized("Profile.aboutDeveloper"))
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        setObservers()
        
        myNFTSection.setAction { self.myNTFSectionClick() }
        favoriteNTFSection.setAction { self.favoritesNTFSectionClick() }
        developerSection.setAction { self.developerSectionClick() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewLoaded()
    }

    @objc
    private func editProfileButtonClick() {
        viewModel.profileEditRequire()
        
        let controller = EditProfileViewController()
        controller.setProfileModel(viewModel.getProfileInfo())
        controller.onProfileInfoChanged { [weak self] model in
            guard let self else { return }
            self.viewModel.setProfileInfo(model)
        }
        present(controller, animated: true)
    }
    
    private func myNTFSectionClick() {
        let controller = MyNTFViewController(viewModel: DI.injectMyNTFViewModel())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    private func favoritesNTFSectionClick() {
        let controller = FavoritesNTFViewController(viewModel: DI.injectFavoritesNTFViewModel())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    private func developerSectionClick() {
        //TODO swich on DeveloperViewController
    }
    
    private func updateMyNTFCount(_ count: Int?) {
        myNFTSection.setContentCount(count)
    }
    
    private func updateFavoritesNTFCount(_ count: Int?) {
        favoriteNTFSection.setContentCount(count)
    }
    
    private func updateProfileInformation(from model: ProfileModel) {
        userAvatar.image = model.avatar ?? UIImage(systemName: "person.circle.fill")
        userName.text = model.name
        userDescription.text = model.description
        userLink.text = model.link
    }
    
//MARK: - Observers
    private func setObservers() {
        viewModel.observeProfileInfo { [weak self] profileModel in
            guard let self else { return }
            self.updateProfileInformation(from: profileModel)
        }
        viewModel.observeMyNTFCount { [weak self] NTFcount in
            guard let self else { return }
            self.updateMyNTFCount(NTFcount)
        }
        viewModel.observeFavoritesNTFCount { [weak self] NTFcount in
            guard let self else { return }
            self.updateFavoritesNTFCount(NTFcount)
        }
    }
}

//MARK: - Configure layout
extension ProfileViewController {
    
    private struct Dimension {
        static let commonMargin: CGFloat = 16
        static let avatarDiameter: CGFloat = 70
        static let functionalSectionHeigth: CGFloat = 56
    }
    
    private func configureLayout() {
        
        view.addSubView(
            editProfileButton, width: 42, heigth: 42,
            top: AnchorOf(view.topAnchor, 52),
            trailing: AnchorOf(view.trailingAnchor, -16)
        )
        
        view.addSubView(
            userAvatar, width: Dimension.avatarDiameter, heigth: Dimension.avatarDiameter,
            top: AnchorOf(editProfileButton.bottomAnchor, 20),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin)
        )
        
        view.addSubView(
            userName,
            leading: AnchorOf(userAvatar.trailingAnchor, 16),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin),
            centerY: AnchorOf(userAvatar.centerYAnchor)
        )
               
        view.addSubView(
            userDescription,
            top: AnchorOf(userAvatar.bottomAnchor, 20),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
                
        view.addSubView(
            userLink,
            top: AnchorOf(userDescription.bottomAnchor, 12),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
  
        view.addSubView(
            myNFTSection, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(userLink.bottomAnchor, 40),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
        
        view.addSubView(
            favoriteNTFSection, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(myNFTSection.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
    
        view.addSubView(
            developerSection, heigth: Dimension.functionalSectionHeigth,
            top: AnchorOf(favoriteNTFSection.bottomAnchor),
            leading: AnchorOf(view.leadingAnchor, Dimension.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Dimension.commonMargin)
        )
    }
}
