//
//  FavoritesNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class FavoritesNTFViewModel: FavoritesNTFViewModelProtocol {
    
    private let ntfRepository: NTFRepository
    
    private var updFavoritesNTFsIds = [String]()
    
    private var ntfs = [NtfPack]()
    
    private var updateNTFModel: ( (IndexPath) -> Void )?
    
    private var setPlaceholder: ( (Bool) -> Void )?
    
    init(
        ntfRepository: NTFRepository,
        favoritesNTFsID: [String]
    ) {
        self.ntfRepository = ntfRepository
        self.updFavoritesNTFsIds = favoritesNTFsID
        self.ntfs = favoritesNTFsID.map { NtfPack(id: $0, ntf: nil) }
    }
    
    func onViewWillAppear() {
        if ntfs.isEmpty {
            setPlaceholder?(true)
            return
        }
        setPlaceholder?(false)
        
        ntfRepository.loadNTFsByID(updFavoritesNTFsIds) { [weak self] ntfId, ntf in
            guard let self else { return }
            self.updateNtfInPack(id: ntfId, ntf: ntf)
        }
    }
        
    func itemCount() -> Int {
        ntfs.count
    }
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel? {
        if ntfs.isEmpty || indexPath.item > ntfs.count - 1 { return nil }
        return map(ntfs[indexPath.item].ntf)
    }
    
    func changeFavoriteNTFStatus(for indexPath: IndexPath) {
        let id = ntfs[indexPath.item].id
        guard let _ = updFavoritesNTFsIds.filter({$0 == id}).first else {
            updFavoritesNTFsIds.append(id)
            return
        }
        updFavoritesNTFsIds = updFavoritesNTFsIds.filter {$0 != id}
    }
    
    func getUpdatedFavoritesNTFsIds() -> [String] {
        updFavoritesNTFsIds
    }
    
    func refreshObject(for indexPath: IndexPath) {
        if indexPath.item > ntfs.count - 1 { return }
        let ntfID = ntfs[indexPath.item].id
        
        ntfRepository.loadNTFByID(ntfID) { [weak self] ntf in
            guard let self else { return }
            updateNtfInPack(itemIndex: indexPath.item, ntf: ntf)
        }
    }
    
    func observeUpdateNTFModel(_ completion: @escaping (IndexPath) -> Void) {
        self.updateNTFModel = completion
    }
    
    func observeUpdatedPlaceholderState(_ completion: @escaping (Bool) -> Void) {
        self.setPlaceholder = completion
    }
    
    private func updateNtfInPack(id: String, ntf: NTFModel?) {
        var itemIndex = -1
        for index in 0 ... ntfs.count - 1 where ntfs[index].id == id {
            itemIndex = index
            break
        }
        
        if itemIndex == -1 {
            ntfs.append(NtfPack(id: id, ntf: ntf))
            itemIndex = ntfs.count - 1
        }
        
        updateNtfInPack(itemIndex: itemIndex, ntf: ntf)
    }
        
    private func updateNtfInPack(itemIndex: Int, ntf: NTFModel?) {
        ntfs[itemIndex].ntf = ntf
        let indexPath = IndexPath(item: itemIndex, section: 0)
        updateNTFModel?(indexPath)
    }
    
    private func map(_ model: NTFModel?) -> FavoritesNTFScreenModel? {
        guard let model else { return nil }
        
        return FavoritesNTFScreenModel(
            id: model.id,
            title: model.title,
            artworkUrl: model.artworkUrl,
            price: (String(format: "%.2f", model.price)).replacingOccurrences(of: ".", with: ","),
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

