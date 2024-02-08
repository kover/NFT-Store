//
//  NTFRepositoryImpl.swift
//  FakeNFT
//
//  Created by Avtor_103 on 28.01.2024.
//

import Foundation

final class NTFRepositoryImpl: NTFRepository {
    
    private let networkClient: NetworkClient
    
    private var ntfsCache = [NTFModel]()
    
    private let requestQueue = RequestQueue<String>()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadNTFsByID(_ IDs: [String], handler: @escaping (String, NTFModel?) -> Void) {
        var idListForRequest = [String]()
        for id in IDs {
            if let ntf = getNtfFromCacheByID(id) {
                handler(id, ntf)
                continue
            }
            idListForRequest.append(id)
        }
        if idListForRequest.isEmpty { return }
       
        requestQueue.add(IDs)
        
        requestQueue.request { ntfID in
            self.fetchNTFbyID(ntfID) { [weak self] (result: Result<NTFResponseBody, Error>) in
                guard let self else { return }
                var ntf: NTFModel?
                
                switch result {
                case .success(let ntfResponseBody):
                    ntf = self.map(dto: ntfResponseBody)
                case .failure(_):
                    ntf = nil
                }
                
                if let ntf { self.ntfsCache.append(ntf) }
                handler(ntfID, ntf)
                
                requestQueue.next()
            }
        }
        requestQueue.next()
    }
    
    func loadNTFByID(_ id: String, handler: @escaping (NTFModel?) -> Void) {
        if let ntf = getNtfFromCacheByID(id) {
            handler(ntf)
            return
        }
        
        fetchNTFbyID(id) { [weak self] (result: Result<NTFResponseBody, Error>) in
            guard let self else { return }
            var ntf: NTFModel?
            
            switch result {
            case .success(let ntfResponseBody):
                ntf = self.map(dto: ntfResponseBody)
            case .failure(_):
                ntf = nil
            }
            if let ntf { self.ntfsCache.append(ntf) }
            handler(ntf)
        }
    }
    
    func loadNTFbyID(id: String, handler: @escaping (NTFModel?) -> Void) {
        fetchNTFbyID(id) { [weak self] (result: Result<NTFResponseBody, Error>) in
            guard let self else { return }
            var ntfModel: NTFModel?
            
            switch result {
            case .success(let ntfResponseBody):
                ntfModel = self.map(dto: ntfResponseBody)
            case .failure(_):
                ntfModel = nil
            }
            handler(ntfModel)
        }
    }
    
    private func getNtfFromCacheByID(_ id: String) -> NTFModel? {
        ntfsCache.filter({ $0.id == id }).first
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
