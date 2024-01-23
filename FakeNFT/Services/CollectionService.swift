//
//  CollectionService.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 23.01.2024.
//

import Foundation

protocol CollectionServiceProtocol {
    func getNft(by id: String, completion: @escaping (Result<NftItem, Error>) -> Void)
}

struct CollectionService: CollectionServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNft(by id: String, completion: @escaping (Result<NftItem, Error>) -> Void) {
        let request = NftByIdRequest(id: id)
        networkClient.send(request: request, type: NftItem.self) { result in
            switch result {
            case .success(let item):
                completion(.success(item))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
