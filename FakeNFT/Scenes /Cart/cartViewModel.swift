//
//  cartViewModel.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 14.01.2024.
//

import Foundation

final class cartViewModel {
    let serviceAssembly: ServicesAssembly
    
    let mockNFTs = [
        NftModel(id: "1", name: "April", images: ["url_to_image_1"], price: 1.78, rating: 1),
        NftModel(id: "2", name: "Greena", images: ["url_to_image_2"], price: 1.78, rating: 3),
        NftModel(id: "3", name: "Spring", images: ["url_to_image_3"], price: 1.78, rating: 5),
    ]

//    let Order = OrderModel(nfts: ["1", "2"], id: "order1")
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func totalAmount() -> Double {
        return mockNFTs.reduce(0) {$0 + $1.price}
    }
    
    func numberOfNFTs() -> Int {
        return mockNFTs.count
    }
}
