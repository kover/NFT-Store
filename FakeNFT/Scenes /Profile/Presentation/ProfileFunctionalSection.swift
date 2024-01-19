//
//  ProfileFunctionalSection.swift
//  FakeNFT
//
//  Created by Avtor_103 on 17.01.2024.
//

import UIKit

class ProfileFunctionalSection {
    
    let view = UIView()
    
    private let contentTitleLabel = UILabel()
    
    private let contentCountLabel = UILabel()
    
    private var onSectionClick: ( () -> Void )?
    
    func setup() {
        if view.superview == nil { return }
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevron.tintColor = .ypBlack
        chevron.contentMode = .scaleAspectFill
        
        view.addSubView(
            chevron, width: 8, heigth: 20,
            trailing: AnchorOf(view.trailingAnchor),
            centerY: AnchorOf(view.centerYAnchor)
        )
        
        contentTitleLabel.textColor = .ypBlack
        contentTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        //titleLabel.textAlignment = .left
        
        view.addSubView(
            contentTitleLabel,
            leading: AnchorOf(view.leadingAnchor),
            centerY: AnchorOf(view.centerYAnchor)
        )
        
        contentCountLabel.textColor = contentTitleLabel.textColor
        contentCountLabel.font = contentTitleLabel.font
        
        view.addSubView(
            contentCountLabel,
            leading: AnchorOf(contentTitleLabel.trailingAnchor),
            centerY: AnchorOf(view.centerYAnchor)
        )
        
        view.backgroundColor = .clear
        contentTitleLabel.backgroundColor = .clear
        chevron.backgroundColor = .clear
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: nil, action: #selector(onViewClick))
        )
    }
    
    func setContentTitle(_ title: String) {
        contentTitleLabel.text = title
    }
    
    func setContentCount(_ count: Int?) {
        guard let count else {
            contentCountLabel.text = ""
            return
        }
        contentCountLabel.text = " (\(count))"
    }
    
    func setAction(_ action: @escaping () -> Void) {
        onSectionClick = action
    }
    
    @objc
    private func onViewClick() {
        onSectionClick?()
    }
}
