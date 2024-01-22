//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 22.01.2024.
//

import Foundation

final class CollectionViewModel {

    @Observable
    private(set) var collection: NftCollection

    init(collection: NftCollection) {
        self.collection = collection
    }
}
