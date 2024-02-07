//
//  MyNTFViewModel.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class MyNTFViewModel: MyNTFViewModelProtocol {
    
    private let ntfRepository: NTFRepository
    
    private let myNTFsIds: [String]
    
    private var ntfList = [NTFModel]()
    
    init(
        ntfRepository: NTFRepository,
        myNTFsIds: [String]
    ) {
        self.ntfRepository = ntfRepository
        self.myNTFsIds = myNTFsIds
    }
    
    func itemCount() -> Int {
        ntfList.count
    }
    
    func object(for indexPath: IndexPath) -> MyNTFScreenModel? {
        if ntfList.isEmpty { return nil }
        return map(ntfList[indexPath.item])
    }
    
    private func map(_ model: NTFModel) -> MyNTFScreenModel {
        MyNTFScreenModel(
            id: model.id,
            title: model.title,
            artworkUrl: model.artworkUrl,
            author: model.author,
            price: String(model.price),
            currency: model.currency,
            rating: model.rating,
            isFavorite: false // mocked
        )
    }
    
}
