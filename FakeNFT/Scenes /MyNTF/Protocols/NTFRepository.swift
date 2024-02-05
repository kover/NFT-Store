//
//  NTFRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol NTFRepository {
    
    func loadMyNTFsByID(_ IDs: [String]) -> [NTFModel]
    
    func loadFavoritesNTFsByID(_ IDs: [String])
    
    func loadFavoritesNTFsFromCache() -> [NTFModel]
}
