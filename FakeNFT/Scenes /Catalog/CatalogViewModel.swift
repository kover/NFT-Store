//
//  CalatogViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import Foundation

final class CatalogViewModel {

    let serviceAssembly: ServicesAssembly
    var alertPresenter: AlertPresenterProtocol?

    private let defaults = UserDefaults.standard
    private var sortOrder: SortOrder? {
        didSet {
            defaults.set(sortOrder?.rawValue, forKey: "sortOrder")
        }
    }

    @Observable
    private(set) var collections: [NftCollection] = []

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        if let order = defaults.string(forKey: "sortOrder") {
            sortOrder = SortOrder.init(rawValue: order)
        }
        loadCollections()
    }

    func loadCollections(completion: (() -> Void)? = nil) {
        UIBlockingProgressHUD.show()
        serviceAssembly.catalogService.getCollections { [weak self] result in
            switch result {
            case .success(let items):
                switch self?.sortOrder {
                case .name:
                    self?.collections = items.sorted(by: { $0.name < $1.name })
                case .nfts:
                    self?.collections = items.sorted(by: { $0.nfts.count < $1.nfts.count })
                case nil:
                    self?.collections = items
                }
            case .failure:
                self?.showNetworkError {
                    self?.loadCollections(completion: completion)
                }
            }
            UIBlockingProgressHUD.dismiss()
            completion?()
        }
    }

    func sortCollectionsByName() {
        collections = collections.sorted(by: { $0.name < $1.name })
        sortOrder = SortOrder.name
    }

    func sortCollectionsByCount() {
        collections = collections.sorted(by: { $0.nfts.count < $1.nfts.count })
        sortOrder = SortOrder.nfts
    }
}
private extension CatalogViewModel {
    func showNetworkError(completion: @escaping () -> Void) {
        guard let alertPresenter = alertPresenter else {
            return
        }
        let model = Alert(
            title: NSLocalizedString("Error.title", comment: "Title for the error alert"),
            message: NSLocalizedString("Error.network", comment: "Message for the network error"),
            actionTitle: NSLocalizedString("Error.repeat", comment: "Title for the repeat button"),
            completion: completion
        )
        alertPresenter.showAlert(using: model)
    }
}
