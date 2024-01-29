//
//  CurrencyService.swift
//  FakeNFT
//
//  Created by Konstantin Penzin on 30.01.2024.
//

import Foundation

protocol CurrencyServiceProtocol {
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void)
}

struct CurrencyService: CurrencyServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        let request = CurrenciesRequest()
        networkClient.send(request: request, type: [Currency].self) { result in
            switch result {
            case .success(let currencies):
                completion(.success(currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
