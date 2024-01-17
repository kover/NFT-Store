//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import UIKit

final class CatalogViewController: UIViewController {
    let viewModel: CatalogViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.catalogTableViewCellIdentifier)
        
        return tableView
    }()
    
    private lazy var noItemsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Catalog.empty", comment: "The message to show if catalogs list is empty")
        
        label.isHidden = true
        
        return label
    }()
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        setupSubviews()
        setupLayout()
        
        bind()
    }
}
// MARK: - Private routines
private extension CatalogViewController {
    func configureNavBar() {
        let sortButton = UIBarButtonItem(
            image: UIImage(named: "Sort"),
            style: .plain,
            target: self,
            action: #selector(sortItems)
        )
        sortButton.tintColor = UIColor.segmentActive
        
        navigationItem.setRightBarButton(sortButton, animated: true)
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.backgroundView = noItemsLabel
        noItemsLabel.constraintCenters(to: view)
    }
    
    @objc func sortItems() {
        // TODO: Implement sorting
    }
    
    func bind() {
        viewModel.$collections.bind {[weak self] collections in
            self?.tableView.reloadData()
            self?.noItemsLabel.isHidden = !collections.isEmpty
        }
    }
}
// MARK: UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.catalogTableViewCellIdentifier, for: indexPath) as? CatalogTableViewCell else {
            return UITableViewCell()
        }
        
        let collection = viewModel.collections[indexPath.row]
        cell.setupCell(for: collection, completion: {})
        return cell
    }
}
// MARK: UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        179
    }
}
