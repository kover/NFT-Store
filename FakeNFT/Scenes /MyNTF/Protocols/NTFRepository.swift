//
//  NTFRepository.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

protocol NTFRepository {
    
    func loadMyNTFsByID(_ ntfModel: ProfileNTFsModel, handler: @escaping ([NTFModel]?) -> Void)
    
    func loadFavoritesNTFsByID(_ IDs: [String], handler: @escaping ([NTFModel]?) -> Void)
    
    func loadFavoritesNTFsFromCache() -> [NTFModel]
}
