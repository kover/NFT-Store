//
//  NftDetailViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 29.01.2024.
//

import Foundation

protocol DetailsViewModelProtocol {
    var nft: NftItem { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {
//    private let serviceAssembly: ServicesAssembly
//    var alertPresenter: AlertPresenterProtocol?

    private(set) var nft: NftItem

    init(nft: NftItem) {
        self.nft = nft
    }
}
