//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Avtor_103 on 19.01.2024.
//

import UIKit
import Kingfisher

final class EditProfileViewController: UIViewController {
    
    private let closeButton: UIButton = {
        let buttonImage = UIImage(
            systemName: "xmark",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .default)
        )
        let button = UIButton.systemButton(
            with: buttonImage ?? UIImage(),
            target: nil,
            action: #selector(closeButtonClick)
        )
        button.tintColor = .ypBlack
        button.backgroundColor = .clear
        return button
    }()
    
    private let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Property.avatarDiameter/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .clear
        textField.textColor = .ypBlack
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.placeholder = localized("Profile.Edit.UserName.Placeholder")
        return textField
    }()
    
    private let userDescriptionField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 16
        textView.backgroundColor = .clear
        textView.textColor = .ypBlack
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainer.lineBreakMode = .byWordWrapping
        return textView
    }()
    
    private let userLinkField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.backgroundColor = .clear
        textField.textColor = .ypBlack
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.placeholder = localized("Profile.Edit.UserLink.Placeholder")
        return textField
    }()
    
    private var onProfileInfoChanged: ( (ProfilePersonalDataModel) -> Void )?
    
    private var avatarUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        userAvatar.isUserInteractionEnabled = true
        userAvatar.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(changeUserAvatar))
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let updatedProfileModel = ProfilePersonalDataModel(
            avatarUrl: avatarUrl,
            name: userNameField.text ?? "",
            description: userDescriptionField.text ?? "",
            link: userLinkField.text ?? ""
        )
        onProfileInfoChanged?(updatedProfileModel)
    }
    
    func setProfileModel(_ model: ProfilePersonalDataModel?) {
        avatarUrl = model?.avatarUrl
        updateProfileInformation(from: model)
    }
    
    func onProfileInfoChanged(_ completion: @escaping (ProfilePersonalDataModel) -> Void) {
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
            AlertAction(title: localized("Camera")) {[weak self] in
                guard let self else { return }
                imagePicker.sourceType = .camera
                self.delayedRelease()
            },
            AlertAction(title: localized("Photo Library")) {[weak self] in
                guard let self else { return }
                imagePicker.sourceType = .photoLibrary
                self.delayedRelease()
            },
            AlertAction(title: localized("Photo Link")) {[weak self] in
                guard let self else { return }
                AlertController.showInputDialog(
                    alertPresenter: self,
                    title: localized("Profile.Edit.EnterAvatarLink")) { urlString in
                        let newAvatarUrl = URL(string: urlString)
                        self.updateProfileAvatar(for: newAvatarUrl)
                        self.avatarUrl = newAvatarUrl
                    }
            }
        ]
        AlertController.multiAction(alertPresenter: self, title: nil, actions: actions)
    }
    
    private func updateProfileInformation(from model: ProfilePersonalDataModel?) {
        guard let model else { return }
        updateProfileAvatar(for: model.avatarUrl)
        userNameField.text = model.name
        userDescriptionField.text = model.description
        userLinkField.text = model.link
    }
    
    private func updateProfileAvatar(for url: URL?) {
        userAvatar.kf.setImage(
            with: url
        )
    }
    
    private func delayedRelease() {
        AlertController.showNotification(
            alertPresenter: self,
            title: localized("Not available"),
            message: localized("Will avaible in the next release")
        )
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
                
        view.addSubView(
            closeButton, width: Property.closeButtonWidth, heigth: Property.closeButtonWidth,
            top: AnchorOf(view.topAnchor, 28),
            trailing: AnchorOf(view.trailingAnchor, -Property.commonMargin)
        )
        
        view.addSubView(
            userAvatar, width: Property.avatarDiameter, heigth: Property.avatarDiameter,
            top: AnchorOf(closeButton.bottomAnchor, 22),
            centerX: AnchorOf(view.centerXAnchor)
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
