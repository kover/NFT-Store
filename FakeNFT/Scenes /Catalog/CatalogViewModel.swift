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

    @Observable
    private(set) var collections: [NftCollection] = []

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadCollections()
    }

    func loadCollections(completion: (() -> Void)? = nil) {
        UIBlockingProgressHUD.show()
        serviceAssembly.catalogService.getCollections { [weak self] result in
            switch result {
            case .success(let items):
                self?.collections = items
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
    }

    func sortCollectionsByCount() {
        collections = collections.sorted(by: { $0.nfts.count < $1.nfts.count })
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
