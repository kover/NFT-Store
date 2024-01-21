//
//  CalatogViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import Foundation

final class CatalogViewModel {

    let serviceAssembly: ServicesAssembly

    @Observable
    private(set) var collections: [NftCollection] = []

    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadCollections()
    }

    func loadCollections(completion: (() -> Void)? = nil) {
        UIBlockingProgressHUD.show()
        serviceAssembly.catalogService.getCollections { [weak self] result in
            switch result {
            case .success(let items):
                self?.collections = items
            case .failure(let error):
                // TODO: - Show alert with error details
                print(error.localizedDescription)
            }
            UIBlockingProgressHUD.dismiss()
            completion?()
        }
    }

    func sortCollectionsByName() {
        collections = collections.sorted(by: { $0.name < $1.name })
    }

    func sortCollectionsByCount() {
        collections = collections.sorted(by: { $0.nfts.count < $1.nfts.count })
    }
}
