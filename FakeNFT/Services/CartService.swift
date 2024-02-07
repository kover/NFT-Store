//
//  CartService.swift
//  FakeNFT
//
//  Created by Алишер Дадаметов on 23.01.2024.
//
import Foundation

protocol CartServiceProtocol {
    func getOrder(completion: @escaping (Result<Order, Error>) -> Void)
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
    
    func getOrder(completion: @escaping (Result<Order, Error>) -> Void) {
        let request = GetNftOrderRequest()
        networkClient.send(request: request, type: Order.self) { result in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateOrder(_ order: Order, completion: @escaping (Result<Order, Error>) -> Void) {
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
    
    func getCurrencies(completion: @escaping (Result<[CurrencyModel], Error>) -> Void) {
        let request = GetCurrenciesRequest()
        networkClient.send(request: request, type: [CurrencyModel].self) { result in
            switch result {
            case.success(let currencies):
                completion(.success(currencies))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func makePayment(with currencyId: String, completion: @escaping (Result<PaymentResponse, Error>) -> Void) {
        let request = PaymentResponseRequest(id: currencyId)

        networkClient.send(request: request, type: PaymentResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.success {
                        completion(.success(response))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Payment failed: server returned success as false"])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
