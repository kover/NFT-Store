//
//  CatalogService.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 17.01.2024.
//

import Foundation

protocol CatalogServiceProtocol {
    func getCollections(completion: @escaping (Result<[NftCollection], Error>) -> Void)
}

struct CatalogService: CatalogServiceProtocol {

    private let networkClient: NetworkClient

    init(
        networkClient: NetworkClient = DefaultNetworkClient()
    ) {
        self.networkClient = networkClient
    }

    func getCollections(completion: @escaping (Result<[NftCollection], Error>) -> Void) {
        let request = CollectionsRequest()
        networkClient.send(request: request, type: [NftCollection].self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
