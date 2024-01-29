//
//  NftDetailViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import Foundation

protocol DetailsViewModelProtocol {
    var nft: NftItem { get }
    var collection: NftCollection { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {
//    private let serviceAssembly: ServicesAssembly
//    var alertPresenter: AlertPresenterProtocol?
    private(set) var nft: NftItem
    private(set) var collection: NftCollection

    init(nft: NftItem, collection: NftCollection) {
        self.nft = nft
        self.collection = collection
    }
}
