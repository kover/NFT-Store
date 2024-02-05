//
//  NTFRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class NTFRepositoryImpl: NTFRepository {

    private var favoritesNTFsCache = [NTFModel]()
    
    func loadMyNTFsByID(_ IDs: [String]) -> [NTFModel] {
        MockedData.NTFList //mocked storage
    }
    
    func loadFavoritesNTFsByID(_ IDs: [String]) {
        favoritesNTFsCache = MockedData.NTFList //mocked storage
    }
    
    func loadFavoritesNTFsFromCache() -> [NTFModel] {
        favoritesNTFsCache
    }
}
