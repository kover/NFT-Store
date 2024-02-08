//
//  MyNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class MyNTFViewModel: MyNTFViewModelProtocol {
        
    private let ntfRepository: NTFRepository
    
    private let settingsRepository: SettingsRepository
    
    private var updFavoritesNTFsIds = [String]()
    
    private var ntfs = [NtfPack]()
    
    private var updateNTFModel: ( (IndexPath) -> Void )?
    
    private var updateNTFCollection: ( () -> Void )?
    
    private var setPlaceholder: ( (Bool) -> Void )?
    
    init(
        ntfRepository: NTFRepository,
        settingsRepository: SettingsRepository,
        profileNTFsModel: ProfileNTFsModel
    ) {
        self.ntfRepository = ntfRepository
        self.settingsRepository = settingsRepository
   
        self.ntfs = profileNTFsModel.myNtfIds.map { NtfPack(id: $0, ntf: nil) }
        self.updFavoritesNTFsIds = profileNTFsModel.favoritesNtsIds
    }
    
    func onViewWillAppear() {
        if ntfs.isEmpty {
            setPlaceholder?(true)
            return
        }
        setPlaceholder?(false)
        
        let ids = ntfs.map { $0.id }
        ntfRepository.loadNTFsByID(ids) { [weak self] ntfId, ntf in
            guard let self else { return }
            self.updateNtfInPack(id: ntfId, ntf: ntf)
        }
    }
    
    func itemCount() -> Int {
        ntfs.count
    }
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel? {
        if ntfs.isEmpty || indexPath.item > ntfs.count - 1 { return nil }
        
        return map(ntfs[indexPath.item].ntf)
    }
    
    func refreshObject(for indexPath: IndexPath) {
        if indexPath.item > ntfs.count - 1 { return }
        let ntfID = ntfs[indexPath.item].id
        
        ntfRepository.loadNTFByID(ntfID) { [weak self] ntf in
            guard let self else { return }
            updateNtfInPack(itemIndex: indexPath.item, ntf: ntf)
            
            guard let ntf else { return }
            sortNTFs(settingsRepository.getSortingRule())
        }
    }
    
    func changeFavoriteNTFStatus(for indexPath: IndexPath) {
        let id = ntfs[indexPath.item].id
        guard let _ = updFavoritesNTFsIds.filter({$0 == id}).first else {
            updFavoritesNTFsIds.append(id)
            return
        }
        updFavoritesNTFsIds = updFavoritesNTFsIds.filter {$0 != id}
    }
    
    func sortNTFs(_ rule: SortingRule) {
        var notNilNtfs = ntfs.filter { $0.ntf != nil }
        let nilNtfs = ntfs.filter { $0.ntf == nil }
        
        switch rule {
        case .byPrice:
            notNilNtfs.sort { $0.ntf?.price ?? 0 < $1.ntf?.price ?? 0 }
        case .byRating:
            notNilNtfs.sort { $0.ntf?.rating ?? 0 < $1.ntf?.rating ?? 0 }
        case .byTitle:
            notNilNtfs.sort { $0.ntf?.title ?? "" < $1.ntf?.title ?? "" }
        }
        
        ntfs = notNilNtfs
        ntfs.append(contentsOf: nilNtfs)
        
        updateNTFCollection?()
        settingsRepository.saveSortingRule(rule)
    }
    
    func getUpdatedFavoritesNTFsIds() -> [String] {
        updFavoritesNTFsIds
    }
        
    func observeUpdateNTFModel(_ completion: @escaping (IndexPath) -> Void) {
        self.updateNTFModel = completion
    }
    
    func observeUpdateNTFCollection(_ completion: @escaping () -> Void) {
        self.updateNTFCollection = completion
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
    
    private func map(_ model: NTFModel?) -> MyNTFScreenModel? {
        guard let model else { return nil }
        
        return MyNTFScreenModel(
            id: model.id,
            title: model.title,
            artworkUrl: model.artworkUrl,
            author: model.author,
            price: String(model.price),
            currency: model.currency,
            rating: model.rating,
            isFavorite: checkNTFisFavorite(id: model.id)
        )
    }
    
    private func convertToPack(ntf: NTFModel?, id: String) -> NtfPack {
        NtfPack(id: id, ntf: ntf)
    }
    
    private func checkNTFisFavorite(id: String) -> Bool {
        for favoritesNtfID in updFavoritesNTFsIds where favoritesNtfID == id {
            return true
        }
        return false
    }
    
}
