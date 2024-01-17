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
        
        return tableView
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
    }
    
    @objc func sortItems() {
        // TODO: Implement sorting
    }
}
// MARK: UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
// MARK: UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    // TODO: Implement delegate methods when needed
}
