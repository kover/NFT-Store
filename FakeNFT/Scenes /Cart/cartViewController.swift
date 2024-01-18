//
//  cartViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import UIKit

final class CartViewController: UIViewController {
    
    let viewModel: cartViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bottomPanel: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 76)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor.segmentInactive
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.numberOfNFTs()) NFT"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.totalAmount()) ETH" 
        label.textColor = UIColor(hexString: "1C9F00")
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chekoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("К оплате", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.segmentActive
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: cartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        addSubViews()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        let sortButton = UIBarButtonItem(image: UIImage(named: "Sort"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(sortButtonTapped))
        sortButton.tintColor = UIColor.segmentActive
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc func sortButtonTapped() {
        //todo: настроить сортировку
    }
    
    @objc func checkoutButtonTapped() {
        //todo: реализовать переход к экрану выбора валюты
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(bottomPanel)
        bottomPanel.addSubview(quantityLabel)
        bottomPanel.addSubview(totalAmountLabel)
        bottomPanel.addSubview(chekoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomPanel.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomPanel.heightAnchor.constraint(equalToConstant: 76),
            
            quantityLabel.topAnchor.constraint(equalTo: bottomPanel.topAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: bottomPanel.leadingAnchor, constant: 16),
            
            totalAmountLabel.bottomAnchor.constraint(equalTo: bottomPanel.bottomAnchor, constant: -16),
            totalAmountLabel.leadingAnchor.constraint(equalTo: bottomPanel.leadingAnchor, constant: 16),
            
            chekoutButton.topAnchor.constraint(equalTo: bottomPanel.topAnchor, constant: 16),
            chekoutButton.trailingAnchor.constraint(equalTo: bottomPanel.trailingAnchor, constant: -16),
            chekoutButton.widthAnchor.constraint(equalToConstant: 244),
            chekoutButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
}

//MARK: UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfNFTs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension CartViewController: UITableViewDelegate {
    //todo: настроить Tableview
}
