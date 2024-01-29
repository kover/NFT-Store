//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import UIKit

final class CatalogViewController: UIViewController {
    private let viewModel: CatalogViewModel
    private let serviceAssembly: ServicesAssembly
    private var alertPresenter: AlertPresenterProtocol

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .ypWhite
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CatalogTableViewCell.self,
            forCellReuseIdentifier: CatalogTableViewCell.catalogTableViewCellIdentifier
        )
        return tableView
    }()

    private lazy var noItemsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Catalog.empty", comment: "The message to show if catalogs list is empty")
        label.isHidden = true
        return label
    }()

    init(viewModel: CatalogViewModel, serviceAssembly: ServicesAssembly, alertPresenter: AlertPresenterProtocol) {
        viewModel.alertPresenter = alertPresenter
        self.viewModel = viewModel
        self.serviceAssembly = serviceAssembly
        self.alertPresenter = alertPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ypWhite
        navigationItem.backButtonTitle = ""

        alertPresenter.delegate = self

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
        let alertController = UIAlertController(
            title: nil,
            message: NSLocalizedString("Sort.title", comment: "Title for the sort controller on catalog page"),
            preferredStyle: .actionSheet
        )

        let sortByNameAction = UIAlertAction(
            title: NSLocalizedString("Sort.byName", comment: "Title for sort by name action"),
            style: .default
        ) { [weak self] _ in
            self?.viewModel.sortCollectionsByName()
        }
        let sortByCountAction = UIAlertAction(
            title: NSLocalizedString("Sort.byCount", comment: "Title for sort by count action"),
            style: .default
        ) { [weak self] _ in
            self?.viewModel.sortCollectionsByCount()
        }

        let closeAction = UIAlertAction(
            title: NSLocalizedString("Sort.close", comment: "Title for close button in sort controller"),
            style: .cancel
        )

        alertController.addAction(sortByNameAction)
        alertController.addAction(sortByCountAction)
        alertController.addAction(closeAction)

        present(alertController, animated: true)
    }

    @objc func refreshData(_ sender: Any) {
        viewModel.loadCollections { [weak self] in
            self?.refreshControl.endRefreshing()
        }
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CatalogTableViewCell.catalogTableViewCellIdentifier,
            for: indexPath
        ) as? CatalogTableViewCell else {
            return UITableViewCell()
        }

        let collection = viewModel.collections[indexPath.row]
        cell.setupCell(for: collection)
        return cell
    }
}
// MARK: UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        179
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = viewModel.collections[indexPath.row]
        let collectionViewModel = CollectionViewModel(collection: collection, serviceAssembly: serviceAssembly)
        let collectionViewController = CollectionViewController(
            viewModel: collectionViewModel,
            alertPresenter: AlertPresenter(),
            serviceAssembly: serviceAssembly
        )

        navigationController?.pushViewController(collectionViewController, animated: true)
    }
}
