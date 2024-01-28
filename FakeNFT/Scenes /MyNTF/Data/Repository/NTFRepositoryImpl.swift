//
//  NTFRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class NTFRepositoryImpl: NTFRepository {
    
    //mocked storage
    private var myNTF = MockedData.NTFList
    private var favoritesNTF = MockedData.NTFList
    
    func loadMyNTF() -> [NTFModel] {
        myNTF
    }
    
    func loadFavoritesNTF() -> [NTFModel] {
        favoritesNTF
    }
    
    func removeFavoriteNTF(id: String) {
        favoritesNTF = favoritesNTF.filter { $0.id != id }
    }
    
    
}
