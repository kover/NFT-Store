//
//  MyNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class MyNTFViewModel: MyNTFViewModelProtocol {
    
    private let NTFRepository: NTFRepository
    
    private let NTFs: [NTFModel]
    
    init(
        NTFRepository: NTFRepository,
        myNTFsIds: [String]
    ) {
        self.NTFRepository = NTFRepository
        self.NTFs = NTFRepository.loadMyNTFsByID(myNTFsIds)
    }
    
    func itemCount() -> Int {
        NTFs.count
    }
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel? {
        if NTFs.isEmpty { return nil }
        return map(NTFs[indexPath.item])
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
