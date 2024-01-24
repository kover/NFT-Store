//
//  cartViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import UIKit

final class CartViewController: UIViewController {
    
    let viewModel: CartViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
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
        label.text = "\(viewModel.nftModels.count) NFT"
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
    
    private lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина пуста"
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupConstraints()
        
        viewModel.onNFTsLoaded = { [weak self] in
            self?.updateUI()
            self?.tableView.reloadData()
        }
        
        updateUI()
    }
    
    private func createSortButton() -> UIBarButtonItem {
        let sortButton = UIBarButtonItem(image: UIImage(named: "Sort"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(sortButtonTapped))
        sortButton.tintColor = UIColor.segmentActive
        return sortButton
    }
    
    @objc func sortButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "Сортировка", preferredStyle: .actionSheet)
        
        let sortByName = UIAlertAction(title: "Название", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .name)
            self?.tableView.reloadData()
        }
        
        let sortByPrice = UIAlertAction(title: "Цена", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .price)
            self?.tableView.reloadData()
        }
        
        let sortByRating = UIAlertAction(title: "Рейтинг", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .rating)
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alertController.addAction(sortByName)
        alertController.addAction(sortByPrice)
        alertController.addAction(sortByRating)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc func checkoutButtonTapped() {
        //todo: реализовать переход к экрану выбора валюты
    }
    
    private func updateUI() {
        let isCartEmpty = viewModel.nftModels.isEmpty
        tableView.isHidden = isCartEmpty
        bottomPanel.isHidden = isCartEmpty
        totalAmountLabel.isHidden = isCartEmpty
        quantityLabel.isHidden = isCartEmpty
        chekoutButton.isHidden = isCartEmpty
        emptyCartLabel.isHidden = !isCartEmpty
        
        navigationItem.rightBarButtonItem = isCartEmpty ? nil : createSortButton()
        
        if !isCartEmpty {
            tableView.reloadData()
        }
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(bottomPanel)
        view.addSubview(emptyCartLabel)
        bottomPanel.addSubview(quantityLabel)
        bottomPanel.addSubview(totalAmountLabel)
        bottomPanel.addSubview(chekoutButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomPanel.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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

//MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nftModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let nftModel = viewModel.nftModels[indexPath.row]
        cell.configure(with: nftModel)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
