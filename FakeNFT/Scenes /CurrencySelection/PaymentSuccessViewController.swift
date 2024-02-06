//
//  PaymentSuccessViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 02.02.2024.
//

import UIKit

protocol PaymentSuccessDelegate: AnyObject {
    func navigateToCatalog()
}

final class PaymentSuccessViewController: UIViewController {
    
    weak var delegate: PaymentSuccessDelegate?
    
    private lazy var successArtImageView: UIImageView = {
        let image = UIImage(named: "successPayment")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "Успех! Оплата прошла,\nпоздравляем с покупкой!"
        label.textColor = UIColor.ypBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вернуться в каталог", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.ypBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubViews()
        setupConstraints()
        
    }
    
    @objc private func returnButtonTapped() {
        delegate?.navigateToCatalog()
        
        if var viewControllers = self.navigationController?.viewControllers {
            viewControllers.removeAll(where: { $0 is PaymentSuccessViewController || $0 is CurrencySelectionViewController })
            self.navigationController?.setViewControllers(viewControllers, animated: false)
        }
    }

    
    private func addSubViews() {
        view.addSubview(successArtImageView)
        view.addSubview(successLabel)
        view.addSubview(returnButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            successArtImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -71),
            successArtImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successArtImageView.heightAnchor.constraint(equalToConstant: 278),
            successArtImageView.widthAnchor.constraint(equalToConstant: 278),
            
            successLabel.topAnchor.constraint(equalTo: successArtImageView.bottomAnchor, constant: 20),
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successLabel.heightAnchor.constraint(equalToConstant: 56),
            successLabel.widthAnchor.constraint(equalToConstant: 303),
            
            returnButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            returnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            returnButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}
