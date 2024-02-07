//
//  FavoritesNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class FavoritesNTFViewModel: FavoritesNTFViewModelProtocol {
    
    private var initFavoritesNTFsIds = [String]()
    
    private var updFavoritesNTFsIds = [String]()
    
    private let ntfRepository: NTFRepository
    
    private var updateNTFModel: ( (IndexPath) -> Void )?
    
    init(
        ntfRepository: NTFRepository,
        favoritesNTFsID: [String]
    ) {
        self.ntfRepository = ntfRepository
        self.initFavoritesNTFsIds = favoritesNTFsID
        self.updFavoritesNTFsIds = favoritesNTFsID
    }
    
    func onViewDidAppear() {
        if !ntfRepository.loadNTFsFromCache().isEmpty { return }
        
        ntfRepository.loadNTFsByID(initFavoritesNTFsIds) { [weak self] itemIndex in
            guard let self else { return }
            let indexPath = IndexPath(item: itemIndex, section: 0)
            updateNTFModel?(indexPath)
        }
    }
        
    func itemCount() -> Int {
        if ntfRepository.loadNTFsFromCache().isEmpty {
            return initFavoritesNTFsIds.count
        }
        return ntfRepository.loadNTFsFromCache().count
    }
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel? {
        let ntfList = ntfRepository.loadNTFsFromCache()
        if ntfList.isEmpty || indexPath.item > ntfList.count - 1 { return nil }
        
        return map(ntfList[indexPath.item])
    }
    
    func changeFavoriteNTFStatus(for id: String) {
        guard let _ = updFavoritesNTFsIds.filter({$0 == id}).first else {
            updFavoritesNTFsIds.append(id)
            return
        }
        updFavoritesNTFsIds = updFavoritesNTFsIds.filter {$0 != id}
    }
    
    func getUpdatedFavoritesNTFsIds() -> [String] {
        updFavoritesNTFsIds
    }
    
    func refreshNTFforItemIndex(_ itemIndex: Int) {
        let id = initFavoritesNTFsIds[itemIndex]
        ntfRepository.loadNTFbyID(id: id, itemIndex: itemIndex) { [weak self] in
            guard let self else { return }
            let indexPath = IndexPath(item: itemIndex, section: 0)
            updateNTFModel?(indexPath)
        }
    }
    
    func observeUpdateNTFModel(_ completion: @escaping (IndexPath) -> Void) {
        self.updateNTFModel = completion
    }
    
    private func map(_ model: NTFModel?) -> FavoritesNTFScreenModel? {
        guard let model else { return nil }
        
        return FavoritesNTFScreenModel(
            id: model.id,
            title: model.title,
            artworkUrl: model.artworkUrl,
            price: String(model.price),
            currency: model.currency,
            rating: model.rating,
            isFavorite: checkNTFisFavorite(id: model.id)
        )
    }
    
    private func checkNTFisFavorite(id: String) -> Bool {
        for favoritesNtfID in updFavoritesNTFsIds where favoritesNtfID == id {
            return true
        }
        return false
    }
}

