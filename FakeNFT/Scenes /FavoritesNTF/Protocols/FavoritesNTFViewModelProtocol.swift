//
//  FavoritesNTFViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol FavoritesNTFViewModelProtocol {
    
    func onViewDidAppear()
    
    func itemCount() -> Int
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel?
    
    func changeFavoriteNTFStatus(for id: String)
        
    func getUpdatedFavoritesNTFsIds() -> [String]
    
    func refreshNTFforItemIndex(_ itemIndex: Int)
        
    func observeUpdateNTFModel(_ completion: @escaping (IndexPath) -> Void)
        
}
