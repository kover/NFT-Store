//
//  NTFRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol NTFRepository {
    
    func loadMyNTF() -> [NTFModel]
    
    func loadFavoritesNTF() -> [NTFModel]
    
    func removeFavoriteNTF(id: String)
}
