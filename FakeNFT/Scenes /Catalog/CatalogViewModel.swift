//
//  CalatogViewModel.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 12.01.2024.
//

import Foundation

final class CatalogViewModel {
    
    let serviceAssembly: ServicesAssembly
    
    var numberOfRows: Int {
        collections.count
    }
    
    private(set) var collections: [NftCollection] = []
    
    init(serviceAssembly: ServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
}
