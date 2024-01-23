//
//  CartService.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 23.01.2024.
//
import Foundation

protocol CartServiceProtocol {
    func getNftItems(ids: [String], completion: @escaping (Result<[NftModel], Error>) -> Void)
}

struct CartService: CartServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getNftItems(ids: [String], completion: @escaping (Result<[NftModel], Error>) -> Void) {
        var nftItems: [NftModel] = []
        let group = DispatchGroup()
        var errors: [Error] = []

        for id in ids {
            group.enter()
            let request = NftByIdRequest(id: id)
            networkClient.send(request: request, type: NftModel.self) { result in
                defer { group.leave() }
                switch result {
                case .success(let item):
                    nftItems.append(item)
                case .failure(let error):
                    errors.append(error)
                }
            }
        }

        group.notify(queue: .main) {
            if !errors.isEmpty {
                completion(.failure(errors[0]))
            } else {
                completion(.success(nftItems))
            }
        }
    }
}
