//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 22.01.2024.
//

import Foundation

final class CollectionViewModel {

    private let serviceAssembly: ServicesAssembly
    var alertPresenter: AlertPresenterProtocol?

    @Observable
    private(set) var collection: NftCollection

    @Observable
    private(set) var nfts: [NftItem] = []

    @Observable
    private(set) var profile: Profile?

    @Observable
    private(set) var order: Order?

    init(collection: NftCollection, serviceAssembly: ServicesAssembly) {
        self.collection = collection
        self.serviceAssembly = serviceAssembly
        loadProfile()
        loadNfts(by: collection.nfts)
        loadOrder()
    }

    func loadNfts(by ids: [String]) {
        var index: UInt32 = 0
        ids.forEach { id in
            let sleepFor = 1 * index
            index += 1
            DispatchQueue.global().async {
                sleep(sleepFor)
                self.loadNft(by: id)
            }
        }
    }

    func toggleLike(for id: String) {
        UIBlockingProgressHUD.show()
        var likes = profile?.likes ?? []
        likes = likes.contains(where: { $0 == id }) ? likes.filter { $0 != id } : likes + [id]
        let model = Likes(likes: likes)
        serviceAssembly.profileService.setLikes(model) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.profile = profile
            case .failure(let error):
                self?.showNetworkError {
                    self?.toggleLike(for: id)
                }
            }
            UIBlockingProgressHUD.dismiss()
        }
    }

    func toggleOrder(for id: String) {
        UIBlockingProgressHUD.show()
        var nfts = order?.nfts ?? []
        nfts = nfts.contains(where: { $0 == id }) ? nfts.filter { $0 != id } : nfts + [id]
        let model = Order(nfts: nfts)
        serviceAssembly.orderService.setOrder(model) { [weak self] result in
            switch result {
            case .success(let order):
                self?.order = order
            case .failure(let error):
                self?.showNetworkError {
                    self?.toggleOrder(for: id)
                }
            }
            UIBlockingProgressHUD.dismiss()
        }
    }

    func isLikeSet(for id: String) -> Bool {
        return profile?.likes.contains { $0 == id } ?? false
    }

    func isInOrder(_ id: String) -> Bool {
        return order?.nfts.contains { $0 == id } ?? false
    }
}
// MARK: - Private routines
private extension CollectionViewModel {
    func loadProfile() {
        serviceAssembly.profileService.getProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.profile = profile
            case .failure:
                self?.showNetworkError {
                    self?.loadProfile()
                }
            }
        }
    }

    func loadNft(by id: String) {
        serviceAssembly.collectionService.getNft(by: id) { [weak self] result in
            switch result {
            case .success(let item):
                self?.nfts.append(item)
            case .failure:
                self?.showNetworkError {
                    self?.loadNft(by: id)
                }
            }
        }
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
