//
//  DeleteConfirmationView.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 30.01.2024.
//

import UIKit


final class DeleteConfirmationView: UIView {
    
    var onDeleteConfirmed: (() -> Void)?
    var onCancel: (() -> Void)?
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "Вы уверены, что хотите удалить объект из корзины?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.ypBlack
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.ypRedUniversal, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor.ypBlack
        button.setTitle("Вернуться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.ypWhite, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(nftImageView)
        addSubview(confirmationLabel)
        addSubview(deleteButton)
        addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: centerYAnchor, constant: -162),
            nftImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            
            confirmationLabel.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 12),
            confirmationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmationLabel.heightAnchor.constraint(equalToConstant: 36),
            confirmationLabel.widthAnchor.constraint(equalToConstant: 180),
            
            deleteButton.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.widthAnchor.constraint(equalToConstant: 127),
            
            cancelButton.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 4),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.widthAnchor.constraint(equalToConstant: 127),
        ])
    }
    
    @objc private func deleteButtonTapped() {
        onDeleteConfirmed?()
    }
    
    @objc private func cancelButtonTapped() {
        onCancel?()
    }
    
    func configure(with nft: NftModel) {
        nftImageView.kf.setImage(with: URL(string: nft.images.first ?? ""))
    }
    
}

