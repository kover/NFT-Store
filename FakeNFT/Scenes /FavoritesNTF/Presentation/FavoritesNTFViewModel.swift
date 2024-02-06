//
//  FavoritesNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class FavoritesNTFViewModel: FavoritesNTFViewModelProtocol {
    
    private var updFavoritesNTFsIds = [String]() //temporary property will be removed on next stage
    
    private let ntfRepository: NTFRepository
    
    init(
        ntfRepository: NTFRepository,
        favoritesNTFsID: [String]
    ) {
        self.ntfRepository = ntfRepository
        self.updFavoritesNTFsIds = favoritesNTFsID //temporary step will be removed on next stage
    }
        
    func itemCount() -> Int {
        ntfRepository.loadFavoritesNTFsFromCache().count
    }
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel? {
        let ntfList = ntfRepository.loadFavoritesNTFsFromCache()
        if ntfList.isEmpty { return nil }
        return map(ntfList[indexPath.item])
    }
    
    func removeFavoriteNTF(id: String) {
        //temporary implementation will be update on next stage
        updFavoritesNTFsIds = updFavoritesNTFsIds.filter {$0 != id}
    }
    
    func getUpdatedFavoritesNTFsIds() -> [String] {
        //temporary implementation will be update on next stage
        updFavoritesNTFsIds
    }
    
    private func map(_ model: NTFModel) -> FavoritesNTFScreenModel {
        FavoritesNTFScreenModel(
            id: model.id,
            title: model.title,
            artworkUrl: model.artworkUrl,
            price: String(model.price),
            currency: model.currency,
            rating: model.rating,
            isFavorite: model.isFavorite
        )
    }
}
