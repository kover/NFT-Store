//
//  NTFRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class NTFRepositoryImpl: NTFRepository {
    
    private let networkClient: NetworkClient
    
    private var ntfCache = [NTFModel?]()
    
    private let requestQueue = RequestQueue<String>()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadNTFsByID(_ IDs: [String], handler: @escaping (Int) -> Void) {
        var i = 1
        requestQueue.add(IDs)
        
        requestQueue.request { ntfID in
            self.fetchNTFbyID(ntfID) { [weak self] (result: Result<NTFResponseBody, Error>) in
                guard let self else { return }
                var ntfModel: NTFModel?
                
                switch result {
                case .success(let ntfResponseBody):
                    ntfModel = self.map(dto: ntfResponseBody)
                case .failure(_):
                    ntfModel = nil
                }
                
                if i == 1 { ntfModel = nil }
                
                self.ntfCache.append(ntfModel)
                handler(self.ntfCache.count - 1)
                i += 1
                requestQueue.next()
            }
        }
        requestQueue.next()
    }
    
    func loadNTFbyID(id: String, itemIndex: Int, callback: @escaping () -> Void) {
        fetchNTFbyID(id) { [weak self] (result: Result<NTFResponseBody, Error>) in
            guard let self else { return }
            var ntfModel: NTFModel?
            
            switch result {
            case .success(let ntfResponseBody):
                ntfModel = self.map(dto: ntfResponseBody)
            case .failure(_):
                ntfModel = nil
            }
            self.ntfCache[itemIndex] = ntfModel
            callback()
        }
    }
    
    func loadNTFsFromCache() -> [NTFModel?] {
        ntfCache
    }
    
    private func fetchNTFbyID(_ id: String, handler: @escaping (Result<NTFResponseBody, Error>)-> Void) {
        let ntsRequest = NFTRequest(id: id)
        
        networkClient.send(
            request: ntsRequest,
            type: NTFResponseBody.self) { (result: Result<NTFResponseBody, Error>) in
                switch result {
                case .success(let ntfResponseBody):
                    handler(.success(ntfResponseBody))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
    }
    
    private func map(dto: NTFResponseBody) -> NTFModel {
        let artworkStringUrl = dto.images.first ?? ""
        
        return NTFModel(
            id: dto.id,
            title: dto.name,
            artworkUrl: URL(string: artworkStringUrl),
            author: dto.author,
            price: dto.price,
            currency: "ETH",//mocked
            rating: dto.rating
        )
    }
}
