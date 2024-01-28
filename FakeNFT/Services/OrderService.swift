//
//  OrderService.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 28.01.2024.
//

import Foundation

protocol OrderServiceProtocol {
    func getOrder(completion: @escaping (Result<Order, Error>) -> Void)
    func setOrder(_ order: Order, completion: @escaping (Result<Order, Error>) -> Void)
}

struct OrderService: OrderServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getOrder(completion: @escaping (Result<Order, Error>) -> Void) {
        let request = OrderRequest()
        networkClient.send(request: request, type: Order.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func setOrder(_ order: Order, completion: @escaping (Result<Order, Error>) -> Void) {
        let request = PutOrderRequest(order: order)
        networkClient.send(request: request, type: Order.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
