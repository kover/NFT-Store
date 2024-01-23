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

    let order = OrderModel(nfts: ["1", "2", "3"], id: "order1")

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadNFTs()
    }

    private func loadNFTs() {
        print("Начинаем загрузку NFT...")
        isLoading = true

        serviceAssembly.cartService.getNftItems(ids: order.nfts) { [weak self] result in
            defer {
                self?.isLoading = false
                print("Загрузка NFT завершена.")
            }

            switch result {
            case .success(let nfts):
                print("Успешно загружено NFT: \(nfts)")
                self?.nftModels = nfts
                self?.onNFTsLoaded?()
            case .failure(let error):
                print("Ошибка при загрузке NFT: \(error)")
                self?.onError?(error)
            }
        }
    }

    func totalAmount() -> Float {
        return nftModels.reduce(0) { $0 + $1.price }
    }
}

