//
//  FavoritesNTFViewModelProtocol.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol FavoritesNTFViewModelProtocol {
    
    func itemCount() -> Int
    
    func object(for indexPath: IndexPath) -> FavoritesNTFScreenModel?
    
    func removeFavoriteNTF(id: String)
    
    func getUpdatedFavoritesNTFsIds() -> [String]
    
}
