//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 19.01.2024.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    private let userAvatar = UIImageView()
    
    private let userNameField = UITextField()
    
    private let userDescriptionField = UITextView()
    
    private let userLinkField = UITextField()
    
    private var onProfileInfoChanged: ( (ProfileModel) -> Void )?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let updatedProfileModel = ProfileModel(
            avatar: userAvatar.image,
            name: userNameField.text ?? "",
            description: userDescriptionField.text ?? "",
            link: userLinkField.text ?? ""
        )
        onProfileInfoChanged?(updatedProfileModel)
    }
    
    func setProfileModel(_ model: ProfileModel) {
        updateProfileInformation(from: model)
    }
    
    func onProfileInfoChanged(_ completion: @escaping (ProfileModel) -> Void) {
        self.onProfileInfoChanged = completion
    }
    
    @objc
    private func closeButtonClick() {
        dismiss(animated: true)
    }
    
    @objc
    private func changeUserAvatar() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actions = [
            alertAction(title: localized("Camera")) {[weak self] in
                guard let self else { return }
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            },
            alertAction(title: localized("Photo Library")) {[weak self] in
                guard let self else { return }
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
        ]
        AlertController.multiAction(alertPresenter: self, title: nil, actions: actions)
    }
    
    private func updateProfileInformation(from model: ProfileModel) {
        userAvatar.image = model.avatar
        userNameField.text = model.name
        userDescriptionField.text = model.description
        userLinkField.text = model.link
    }
}
//MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        userAvatar.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }
}

//MARK: - AlertPresenter Protocol
extension EditProfileViewController: AlertPresenterProtocol {
    func present(alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated)
    }
}

//MARK: - Configure layout
extension EditProfileViewController {
    
    private struct Property {
        static let commonMargin: CGFloat = 16
        static let closeButtonWidth: CGFloat = 42
        static let avatarDiameter: CGFloat = 70
        static let avatarCoverBackGroundColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 0.6)
        static let textFileldCornerRadius: CGFloat = 16
    }
    
    final class SectionTitle {
        let view = UILabel()
        init(title: String) {
            view.font = UIFont.boldSystemFont(ofSize: 22)
            view.textColor = .ypBlack
            view.text = title
        }
    }
    
    private func configureLayout() {
        view.backgroundColor = .ypWhite
        
        let closeButtonImage = UIImage(
            systemName: "xmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .default)
        )
        let closeButton = UIButton.systemButton(
            with: closeButtonImage ?? UIImage(),
            target: nil,
            action: #selector(closeButtonClick)
        )
        closeButton.tintColor = .ypBlack
        closeButton.backgroundColor = .clear
        
        view.addSubView(
            closeButton, width: Property.closeButtonWidth, heigth: Property.closeButtonWidth,
            top: AnchorOf(view.topAnchor, 28),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.layer.cornerRadius = Property.avatarDiameter/2
        userAvatar.clipsToBounds = true
        
        view.addSubView(
            userAvatar, width: Property.avatarDiameter, heigth: Property.avatarDiameter,
            top: AnchorOf(closeButton.bottomAnchor, 22),
            centerX: AnchorOf(view.centerXAnchor)
        )
        userAvatar.isUserInteractionEnabled = true
        userAvatar.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(changeUserAvatar))
        )
        
        let userAvatarCover = UIImageView()
        userAvatarCover.backgroundColor = Property.avatarCoverBackGroundColor
        userAvatar.addSubView(
            userAvatarCover, width: Property.avatarDiameter, heigth: Property.avatarDiameter,
            centerX: AnchorOf(userAvatar.centerXAnchor),
            centerY: AnchorOf(userAvatar.centerYAnchor)
        )
        
        
        let changePhotoLabel = UILabel()
        changePhotoLabel.backgroundColor = .clear
        changePhotoLabel.font = UIFont.systemFont(ofSize: 10)
        changePhotoLabel.textColor = .white
        changePhotoLabel.numberOfLines = 0
        changePhotoLabel.textAlignment = .center
        changePhotoLabel.text = localized("Profile.ChangePhoto")
        
        userAvatarCover.addSubView(
            changePhotoLabel,
            centerX: AnchorOf(userAvatarCover.centerXAnchor),
            centerY: AnchorOf(userAvatarCover.centerYAnchor)
        )
        
        let userNameSectionTitle = SectionTitle(title: localized("Profile.Name"))
        view.addSubView(
            userNameSectionTitle.view,
            top: AnchorOf(userAvatar.bottomAnchor, 24),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin)
        )
        
        userNameField.layer.cornerRadius = 16
        userNameField.backgroundColor = .clear
        userNameField.textColor = .ypBlack
        userNameField.font = UIFont.systemFont(ofSize: 17)
        userNameField.placeholder = localized("Profile.Edit.UserName.Placeholder")
        
        let userNameFieldBackground = UIView()
        userNameFieldBackground.layer.cornerRadius = Property.textFileldCornerRadius
        userNameFieldBackground.backgroundColor = .ypLigthGrey
        
        view.addSubView(
            userNameFieldBackground, heigth: 44,
            top: AnchorOf(userNameSectionTitle.view.bottomAnchor, 8),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        userNameFieldBackground.addSubView(
            userNameField,
            top: AnchorOf(userNameFieldBackground.topAnchor),
            bottom: AnchorOf(userNameFieldBackground.bottomAnchor),
            leading: AnchorOf(userNameFieldBackground.leadingAnchor, 16),
            trailing: AnchorOf(userNameFieldBackground.trailingAnchor, -16)
        )
        
        let userDescriptionSectionTitle = SectionTitle(title: localized("Profile.Description"))
        view.addSubView(
            userDescriptionSectionTitle.view,
            top: AnchorOf(userNameFieldBackground.bottomAnchor, 24),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin)
        )
        
        userDescriptionField.layer.cornerRadius = 16
        userDescriptionField.backgroundColor = .clear
        userDescriptionField.textColor = .ypBlack
        userDescriptionField.font = UIFont.systemFont(ofSize: 17)
        userDescriptionField.textContainer.lineBreakMode = .byWordWrapping
        
        let userDescriptionFieldBackground = UIView()
        userDescriptionFieldBackground.layer.cornerRadius = Property.textFileldCornerRadius
        userDescriptionFieldBackground.backgroundColor = .ypLigthGrey
        
        view.addSubView(
            userDescriptionFieldBackground, heigth: 132,
            top: AnchorOf(userDescriptionSectionTitle.view.bottomAnchor, 8),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        userDescriptionFieldBackground.addSubView(
            userDescriptionField,
            top: AnchorOf(userDescriptionFieldBackground.topAnchor, 10),
            bottom: AnchorOf(userDescriptionFieldBackground.bottomAnchor, -10),
            leading: AnchorOf(userDescriptionFieldBackground.leadingAnchor, 16),
            trailing: AnchorOf(userDescriptionFieldBackground.trailingAnchor, -16)
        )
        
        let userLinkSectionTitle = SectionTitle(title: localized("Profile.Link"))
        view.addSubView(
            userLinkSectionTitle.view,
            top: AnchorOf(userDescriptionFieldBackground.bottomAnchor, 24),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin)
        )
        
        userLinkField.layer.cornerRadius = 16
        userLinkField.backgroundColor = .clear
        userLinkField.textColor = .ypBlack
        userLinkField.font = UIFont.systemFont(ofSize: 17)
        userLinkField.placeholder = localized("Profile.Edit.UserLink.Placeholder")
        
        let userLinkFieldBackground = UIView()
        userLinkFieldBackground.layer.cornerRadius = Property.textFileldCornerRadius
        userLinkFieldBackground.backgroundColor = .ypLigthGrey
        
        view.addSubView(
            userLinkFieldBackground, heigth: 44,
            top: AnchorOf(userLinkSectionTitle.view.bottomAnchor, 8),
            leading: AnchorOf(view.leadingAnchor, Property.commonMargin),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        userLinkFieldBackground.addSubView(
            userLinkField,
            top: AnchorOf(userLinkFieldBackground.topAnchor),
            bottom: AnchorOf(userLinkFieldBackground.bottomAnchor),
            leading: AnchorOf(userLinkFieldBackground.leadingAnchor, 16),
            trailing: AnchorOf(userLinkFieldBackground.trailingAnchor, -16)
        )
    }
}
