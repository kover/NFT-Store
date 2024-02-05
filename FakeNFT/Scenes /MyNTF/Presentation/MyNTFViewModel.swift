//
//  MyNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class MyNTFViewModel: MyNTFViewModelProtocol {
    
    private let ntfRepository: NTFRepository
    
    private let ntfList: [NTFModel]
    
    init(
        ntfRepository: NTFRepository,
        myNTFsIds: [String]
    ) {
        self.ntfRepository = ntfRepository
        self.ntfList = ntfRepository.loadMyNTFsByID(myNTFsIds)
    }
    
    func itemCount() -> Int {
        ntfList.count
    }
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel? {
        if ntfList.isEmpty { return nil }
        return map(ntfList[indexPath.item])
    }
    
    private func map(_ model: NTFModel) -> MyNTFScreenModel {
        MyNTFScreenModel(
            id: model.id,
            title: model.title,
            artwork: model.artwork,
            author: model.author,
            price: model.price,
            currency: model.currency,
            rating: model.rating,
            isFavorite: model.isFavorite
        )
    }
    
}
