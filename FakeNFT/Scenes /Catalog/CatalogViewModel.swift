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
    private(set) var collections: [CatalogCell] = []
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
        loadCollections()
    }
    
    func loadCollections() {
        UIBlockingProgressHUD.show()
        serviceAssembly.catalogService.getCollections { [weak self] result in
            switch result {
            case .success(let items):
                self?.collections = items
            case .failure(let error):
                print(error.localizedDescription)
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func sortCollectionsByName() {
        collections = collections.sorted(by: { $0.name < $1.name })
    }
    
    func sortCollectionsByCount() {
        collections = collections.sorted(by: { $0.nftsCount < $1.nftsCount })
    }
}
