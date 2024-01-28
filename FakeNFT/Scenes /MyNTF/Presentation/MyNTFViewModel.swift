//
//  MyNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class MyNTFViewModel: MyNTFViewModelProtocol {
    
    private let NTFRepository: NTFRepository
    
    init(NTFRepository: NTFRepository) {
        self.NTFRepository = NTFRepository
    }
    
    func itemCount() -> Int {
        NTFRepository.loadMyNTF().count
    }
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel? {
        let NTFlist = NTFRepository.loadMyNTF()
        if NTFlist.isEmpty { return nil }
        return map(NTFlist[indexPath.item])
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
