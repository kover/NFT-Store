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
    private var isLoading = false

    var onNFTsLoaded: (() -> Void)?
    var onError: ((Error) -> Void)?

    let order = OrderModel(nfts: ["1ce4f491-877d-48d0-9428-0e0129a80ec9",
                                  "7dc60644-d3cd-4cf9-9854-f5293ebe93f7",
                                  "db196ee3-07ef-44e7-8ff5-16548fc6f434"],
                           id: "order1")

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadNFTs()
    }

    private func loadNFTs() {
        isLoading = true
        UIBlockingProgressHUD.show()

        serviceAssembly.cartService.getNftItems(ids: order.nfts) { [weak self] result in
            defer {
                self?.isLoading = false
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
