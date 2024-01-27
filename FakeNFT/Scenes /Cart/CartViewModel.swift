//
//  cartViewModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import Foundation

final class CartViewModel {
    private let serviceAssembly: ServicesAssembly
    var nftModels: [NftModel] = []
    var onNFTsLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadOrder()
    }

    func loadOrder() {
        UIBlockingProgressHUD.show()

        serviceAssembly.cartService.getOrder { [weak self] result in
            switch result {
            case .success(let order):
                self?.loadNFTs(for: order.nfts)
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                self?.onError?(error)
            }
        }
    }

    private func loadNFTs(for ids: [String]) {
        serviceAssembly.cartService.getNftItems(ids: ids) { [weak self] result in
            defer {
                UIBlockingProgressHUD.dismiss()
            }
            switch result {
            case .success(let nfts):
                self?.nftModels = nfts
                DispatchQueue.main.async {
                    self?.onNFTsLoaded?()
                }
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }



    func totalAmount() -> Float {
        return nftModels.reduce(0) { $0 + $1.price }
    }
}

//MARK: - Sort Functionality

extension CartViewModel {
    func sortNFTs(by criterion: SortingCriterion) {
        switch criterion {
        case .name:
            nftModels.sort { $0.name < $1.name }
        case .price:
            nftModels.sort { $0.price < $1.price }
        case .rating:
            nftModels.sort { $0.rating < $1.rating }
        }
    }
}

enum SortingCriterion {
    case name, price, rating
}
