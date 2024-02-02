//
//  cartViewController.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let viewModel: CartViewModel
    private let serviceAssembly: ServicesAssembly
    
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
        label.textColor = UIColor.ypGreenUniversal
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
        button.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
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
    
    init(viewModel: CartViewModel, serviceAssembly: ServicesAssembly) {
        self.viewModel = viewModel
        self.serviceAssembly = serviceAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        setupConstraints()
        
        viewModel.onNFTsLoaded = { [weak self] in
            self?.updateUI()
            self?.tableView.reloadData()
        }
        
        viewModel.onNftRemoved = { [weak self] in
            self?.hideDeleteConfirmationView()
            self?.tableView.reloadData()
            self?.updateUI()
        }
        
        updateUI()
        configureBackButtonForNextScreen()
    }
    
    private func configureBackButtonForNextScreen() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func createSortButton() -> UIBarButtonItem {
        let sortButton = UIBarButtonItem(image: UIImage(named: "Sort"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(sortButtonTapped))
        sortButton.tintColor = UIColor.segmentActive
        return sortButton
    }
    
    @objc private func sortButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "Сортировка", preferredStyle: .actionSheet)
        
        let sortByName = UIAlertAction(title: "По цене", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .price)
            self?.tableView.reloadData()
        }
        
        let sortByPrice = UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .rating)
            self?.tableView.reloadData()
        }
        
        let sortByRating = UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
            self?.viewModel.sortNFTs(by: .name)
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
        let currencySelectionVM = CurrencySelectionViewModel(serviceAssembly: serviceAssembly)
        let currencySelectionVC = CurrencySelectionViewController(viewModel: currencySelectionVM)
        currencySelectionVC.delegate = self
        currencySelectionVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(currencySelectionVC, animated: true)
    }

    private func updateUI() {
        let isCartEmpty = viewModel.nftModels.isEmpty
        tableView.isHidden = isCartEmpty
        bottomPanel.isHidden = isCartEmpty
        totalAmountLabel.isHidden = isCartEmpty
        quantityLabel.isHidden = isCartEmpty
        chekoutButton.isHidden = isCartEmpty
        emptyCartLabel.isHidden = !isCartEmpty
        quantityLabel.text = "\(viewModel.nftModels.count) NFT"
        totalAmountLabel.text = "\(viewModel.totalAmount()) ETH"
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
    
    func showDeleteConfirmationView(for nft: NftModel, onDelete: @escaping () -> Void, onCancel: @escaping () -> Void) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        let deleteConfirmationView = DeleteConfirmationView()
        deleteConfirmationView.configure(with: nft)
        deleteConfirmationView.onDeleteConfirmed = onDelete
        deleteConfirmationView.onCancel = onCancel
        deleteConfirmationView.frame = window.bounds
        window.addSubview(deleteConfirmationView)

        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 100
        window.insertSubview(blurEffectView, belowSubview: deleteConfirmationView)
    }

    func hideDeleteConfirmationView() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        if let deleteConfirmationView = window.subviews.first(where: { $0 is DeleteConfirmationView }) {
            deleteConfirmationView.removeFromSuperview()
        }

        if let blurEffectView = window.subviews.first(where: { $0.tag == 100 }) {
            blurEffectView.removeFromSuperview()
        }
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
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

//MARK: - UITableViewDelegate

extension CartViewController: CartTableViewCellDelegate {
    func cartTableViewCellDidTapDelete(_ cell: CartTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let nftToRemove = viewModel.nftModels[indexPath.row]

        showDeleteConfirmationView(for: nftToRemove, onDelete: { [weak self] in
            self?.viewModel.removeNftFromOrder(nftToRemove.id)
        }, onCancel: { [weak self] in
            self?.hideDeleteConfirmationView()
        })
    }
}

//MARK: - PaymentSuccessDelegate

extension CartViewController: PaymentSuccessDelegate {
    func navigateToCatalog() {
        tabBarController?.selectedIndex = 0
    }
}


