//
//  ProfileFunctionalSection.swift
//  FakeNFT
//
//  Created by Avtor_103 on 17.01.2024.
//

import UIKit

final class UIProfileFunctionalSection: UIView {
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .clear
        return label
    }()
    
    private let contentCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .clear
        return label
    }()
    
    private var onSectionClick: ( () -> Void )?
    
    init(title: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setup()
        setContentTitle(title)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onViewClick))
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
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
    
    private func setup() {
        self.backgroundColor = .clear
        
        let chevron = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevron.tintColor = .ypBlack
        chevron.contentMode = .scaleAspectFill
        chevron.backgroundColor = .clear
        
        self.addSubView(
            chevron, width: 8, heigth: 20,
            trailing: AnchorOf(self.trailingAnchor),
            centerY: AnchorOf(self.centerYAnchor)
        )
                
        self.addSubView(
            contentTitleLabel,
            leading: AnchorOf(self.leadingAnchor),
            centerY: AnchorOf(self.centerYAnchor)
        )
                
        self.addSubView(
            contentCountLabel,
            leading: AnchorOf(contentTitleLabel.trailingAnchor),
            centerY: AnchorOf(self.centerYAnchor)
        )
    }
}
