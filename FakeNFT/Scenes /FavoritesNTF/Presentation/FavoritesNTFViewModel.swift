//
//  FavoritesNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class FavoritesNTFViewModel: FavoritesNTFViewModelProtocol {
    
    private let NTFRepository: NTFRepository
    
    init(NTFRepository: NTFRepository) {
        self.NTFRepository = NTFRepository
    }
    
    func itemCount() -> Int {
        NTFRepository.loadFavoritesNTF().count
    }
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel? {
        let NTFlist = NTFRepository.loadFavoritesNTF()
        if NTFlist.isEmpty { return nil }
        return map(NTFlist[indexPath.item])
    }
    
    private func map(_ model: NTFModel) -> FavoritesNTFScreenModel {
        FavoritesNTFScreenModel(
            id: model.id,
            title: model.title,
            artwork: model.artwork,
            price: model.price,
            currency: model.currency,
            rating: model.rating,
            isFavorite: model.isFavorite
        )
    }
}
