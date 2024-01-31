//
//  NftDetailViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import Foundation

final class DetailsViewModel {
    private(set) var nft: NftItem
    private(set) var collection: NftCollection
    private let serviceAssembly: ServicesAssembly
    private var alertPresenter: AlertPresenterProtocol?

    @Observable
    private(set) var order: Order?

    var isInOrder: Bool {
        return order?.nfts.contains { $0 == nft.id } ?? false
    }

    init(
        nft: NftItem,
        collection: NftCollection,
        serviceAssembly: ServicesAssembly,
        alertPresenter: AlertPresenterProtocol?
    ) {
        self.nft = nft
        self.collection = collection
        self.serviceAssembly = serviceAssembly
        self.alertPresenter = alertPresenter
        loadOrder()
    }

    func toggleOrder() {
        UIBlockingProgressHUD.show()
        var nfts = order?.nfts ?? []
        nfts = nfts.contains(where: { $0 == nft.id }) ? nfts.filter { $0 != nft.id } : nfts + [nft.id]
        let model = Order(nfts: nfts)
        serviceAssembly.orderService.setOrder(model) { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order
            case .failure:
                self?.showNetworkError {
                    self?.toggleOrder()
                }
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
}
// MARK: - Private routines
private extension DetailsViewModel {
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

    func loadOrder() {
        serviceAssembly.orderService.getOrder { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order
            case .failure:
                self?.showNetworkError {
                    self?.loadOrder()
                }
            }
        }
    }
}
